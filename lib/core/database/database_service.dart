import 'package:medherence/core/model/models/monitor_drug.dart';
import 'package:medherence/core/model/models/progress.dart';
import 'package:medherence/core/model/models/security.dart';
import 'package:medherence/core/model/models/user_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  static const String _databaseName = "medherence_db.db";
  static const int _databaseVersion = 1;

  // Table names
  static const String userTable = "UserData";
  static const String progressTable = "Progress";
  static const String securityTable = "Security";
  static const String monitorDrugTable = "MonitorDrug";

  DatabaseService._constructor();

  // Singleton pattern to ensure only one database instance is used
  // email!1Q
  //enarebebenatthan@gmail.com
  Future<Database> get database async {
    _db ??=
        await _initializeDatabase(); // If _db is null, initialize the database
    return _db!;
  }

  // Initialize the database and create the tables if not already done
  Future<Database> _initializeDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, _databaseName);
https://github.com/medherence-health/mobile_view.git
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createUserDataTable(db);
        await _createProgressTable(db);
        await _createMonitorDrugTakenTable(db);
        await _createSecurity(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Handle database schema changes for version 2 or higher
          // Example: db.execute('ALTER TABLE ...')
        }
      },
    );
  }

  // Create UserData
  Future<void> _createUserDataTable(Database db) async {
    await db.execute('''
      CREATE TABLE $userTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        full_name TEXT,
        user_id TEXT UNIQUE,
        email TEXT,
        password TEXT,
        phone_number TEXT,
        dob TEXT,
        gender TEXT,
        wa_phone_number TEXT,
        ec_name TEXT,
        ec_gender TEXT,
        ec_num TEXT,
        ec_email TEXT,
        ec_relationship TEXT,
        nof_name TEXT,
        nof_gender TEXT,
        nof_num TEXT,
        nof_email TEXT,
        nof_relationship TEXT,
        state TEXT,
        country TEXT,
        local_government_area TEXT,
        ward TEXT,
        city TEXT,
        address TEXT,
        postal_code TEXT,
        first_name TEXT,
        last_name TEXT,
        language TEXT,
        login_type TEXT,
        profile_img TEXT,
        created_at TEXT,
        is_active INTEGER,  -- Store boolean as INTEGER (0 for false, 1 for true)
        role TEXT,
        account_status TEXT,
        facility_id TEXT,
        facility_code TEXT,
        facility_level TEXT,
        facility_ownership TEXT,
        verification_type TEXT,
        verification_code TEXT,
        bank_name TEXT,
        account_number TEXT,
        card_number TEXT,
        medhecoin_balance REAL,
        total_naira_balance REAL,
        subscription_type TEXT,
        subscription_expiration_date INTEGER,
        subscription_total_patients TEXT,  -- Can store as a comma-separated list or JSON
        subscription_patients_slots INTEGER,
        my_referral_code TEXT,
        message TEXT,
        message_type TEXT,
        total_patients TEXT  -- Can store as a comma-separated list or JSON
      );
    ''');
  }

  // Create progress table
  Future<void> _createProgressTable(Database db) async {
    await db.execute('''
      CREATE TABLE $progressTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        progress INTEGER
      );
    ''');
  }

  // Create drug taken table
  Future<void> _createMonitorDrugTakenTable(Database db) async {
    await db.execute('''
      CREATE TABLE $monitorDrugTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        drug_id TEXT,
        time_taken INTEGER,
        next_time_taken INTEGER,
        cycles_left INTEGER
      );
    ''');
  }

  // Create drug taken table
  Future<void> _createSecurity(Database db) async {
    await db.execute('''
      CREATE TABLE $securityTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pin TEXT,
        type TEXT
      );
    ''');
  }

  Future<String> insertUserData(UserData userData) async {
    try {
      // Get a reference to the database.
      final db = await database;

      // Insert the user data into the table, replacing any existing data with the same `userId`.
      await db.insert(
        'UserData',
        userData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ok; // Return success message on successful insertion.
    } catch (error) {
      // Log the error and return a failure message.
      print('Error inserting user data: $error');
      return '$error';
    }
  }

  Future<String> insertMonitorDrug(MonitorDrug monitorDrug) async {
    try {
      // Get a reference to the database.
      final db = await database;

      // Insert the user data into the table, replacing any existing data with the same `userId`.
      await db.insert(
        'MonitorDrug',
        monitorDrug.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ok; // Return success message on successful insertion.
    } catch (error) {
      // Log the error and return a failure message.
      print('Error inserting user data: $error');
      return 'Error: $error';
    }
  }

  Future<String> insertProgress(Progress progress) async {
    try {
      // Get a reference to the database.
      final db = await database;

      // Insert the user data into the table, replacing any existing data with the same `userId`.
      await db.insert(
        progressTable,
        progress.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ok; // Return success message on successful insertion.
    } catch (error) {
      // Log the error and return a failure message.
      print('Error inserting user data: $error');
      return 'Error: $error';
    }
  }

  Future<String> insertSecurity(Security security) async {
    try {
      // Get a reference to the database.
      final db = await database;

      // Insert the user data into the table, replacing any existing data with the same `userId`.
      await db.insert(
        securityTable,
        security.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ok; // Return success message on successful insertion.
    } catch (error) {
      // Log the error and return a failure message.
      print('Error inserting user data: $error');
      return 'Error: $error';
    }
  }

  Future<UserDataResult> getUserDataById(String user_id) async {
    final db = await database;

    try {
      // Query the database to retrieve user data by userId
      final data = await db.query(
        'UserData',
        where: 'user_id = ?',
        whereArgs: [user_id],
      );

      // Check if any data was returned
      if (data.isNotEmpty) {
        // Map the first result to a UserData object using a factory method
        var dbUserData = UserData.fromMap(data.first);
        print("currentUserdb ${dbUserData}");
        return UserDataResult(userData: dbUserData, message: ok);
      }

      // If no matching user is found, return null
      return UserDataResult(userData: null, message: "User not found");
    } catch (error) {
      // Log the error for debugging purposes
      print("Error retrieving user data for user_id=$user_id: $error");
      return UserDataResult(
          userData: null,
          message: "Error retrieving user data for user_id=$user_id: $error");
    }
  }

  Future<MonitorDrugResult> getMonitorDrugById(String drug_id) async {
    final db = await database;

    try {
      // Query the database to retrieve user data by userId
      final data = await db.query(
        'MonitorDrug',
        where: 'drug_id = ?',
        whereArgs: [drug_id],
      );

      // Check if any data was returned
      if (data.isNotEmpty) {
        // Map the first result to a UserData object using a factory method
        var dbMonitorDrug = MonitorDrug.fromMap(data.first);
        print("currentUserdb ${dbMonitorDrug}");
        return MonitorDrugResult(monitorDrug: dbMonitorDrug, message: ok);
      }

      // If no matching user is found, return null
      return MonitorDrugResult(monitorDrug: null, message: "Drug not found");
    } catch (error) {
      // Log the error for debugging purposes
      return MonitorDrugResult(
          monitorDrug: null, message: "Error retrieving data $error");
    }
  }

  Future<ProgressResult> getProgress() async {
    final db = await database;

    try {
      // Query the database to retrieve user data by userId
      final data = await db.query(
        progressTable,
      );

      // Check if any data was returned
      if (data.isNotEmpty) {
        // Map the first result to a UserData object using a factory method
        var dbProgress = Progress.fromMap(data.first);
        print("currentUserdb ${dbProgress}");
        return ProgressResult(progress: dbProgress, message: ok);
      }

      // If no matching user is found, return null
      return ProgressResult(progress: null, message: "Drug not found");
    } catch (error) {
      // Log the error for debugging purposes
      return ProgressResult(
          progress: null, message: "Error retrieving data $error");
    }
  }

  Future<SecurityResult> getSecurity() async {
    final db = await database;

    try {
      // Query the database to retrieve user data by userId
      final data = await db.query(
        securityTable,
      );

      // Check if any data was returned
      if (data.isNotEmpty) {
        // Map the first result to a UserData object using a factory method
        var dbSecurity = Security.fromMap(data.first);
        print("currentUserdb ${dbSecurity}");
        return SecurityResult(security: dbSecurity, message: ok);
      }

      // If no matching user is found, return null
      return SecurityResult(security: null, message: "Drug not found");
    } catch (error) {
      // Log the error for debugging purposes
      return SecurityResult(
          security: null, message: "Error retrieving data $error");
    }
  }

  Future<String> updateUserData(UserData userData) async {
    try {
      // Ensure the database instance is available
      final db = await database;
      if (db == null) return 'Error: Database is not initialized.';

      // Convert user data to a map
      Map<String, dynamic> userMap;
      try {
        userMap = userData.toMap();
      } catch (e) {
        return 'Error: Failed to convert user data.';
      }

      // Attempt to update the user data
      final rowsUpdated = await db.update(
        'UserData',
        userMap,
        where: 'user_id = ?',
        whereArgs: [userData.userId],
      );

      return rowsUpdated > 0 ? ok : 'Error: No matching user found to update.';
    } catch (error, stackTrace) {
      print('Error updating user data: $error\n$stackTrace');
      return 'Error: Unable to update user data.';
    }
  }

  Future<String> updateMonitorDrug(MonitorDrug monitorDrug) async {
    try {
      // Get a reference to the database.
      final db = await database;

      // Attempt to update the user data.
      final rowsUpdated = await db.update(
        'MonitorDrug',
        monitorDrug.toMap(),
        where: 'drug_id = ?',
        whereArgs: [monitorDrug.drug_id],
      );

      // Check if any rows were updated.
      if (rowsUpdated > 0) {
        return ok; // Update was successful.
      } else {
        return 'Error: No matching user found to update.';
      }
    } catch (error) {
      // Handle errors during the update process.
      print('Error updating user data: $error');
      return 'Error: Unable to update  $error';
    }
  }

  Future<String> updateProgress(Progress progress) async {
    try {
      // Get a reference to the database.
      final db = await database;

      // Attempt to update the user data.
      final rowsUpdated = await db.update(
        progressTable,
        progress.toMap(),
      );

      // Check if any rows were updated.
      if (rowsUpdated > 0) {
        return ok; // Update was successful.
      } else {
        return 'Error: No matching user found to update.';
      }
    } catch (error) {
      // Handle errors during the update process.
      print('Error updating user data: $error');
      return 'Error: Unable to update  $error';
    }
  }

  Future<String> updateSecurity(Security security) async {
    try {
      // Get a reference to the database.
      final db = await database;

      // Attempt to update the user data.
      final rowsUpdated = await db.update(
        securityTable,
        security.toMap(),
      );

      // Check if any rows were updated.
      if (rowsUpdated > 0) {
        return ok; // Update was successful.
      } else {
        return 'Error: No matching user found to update.';
      }
    } catch (error) {
      // Handle errors during the update process.
      print('Error updating user data: $error');
      return 'Error: Unable to update  $error';
    }
  }

  Future<String> deleteTree(UserData userData) async {
    final db = await database;

    try {
      // Use a parameterized query to delete the user data by userId
      int rowsAffected = await db.rawDelete(
        'DELETE FROM UserData WHERE user_id = ?',
        [userData.userId],
      );

      if (rowsAffected > 0) {
        // If rows were affected, the deletion was successful
        return ok;
      } else {
        // If no rows were affected, the user was not found
        return 'No user found with ID: ${userData.userId}';
      }
    } catch (error) {
      // Catch any error that occurs during the deletion
      print("Error deleting user: $error"); // Log the error for debugging
      return 'Error: $error';
    }
  }

  Future<String> deleteMonitorDrug(MonitorDrug monitorDrug) async {
    final db = await database;

    try {
      // Use a parameterized query to delete the user data by userId
      int rowsAffected = await db.rawDelete(
        'DELETE FROM MonitorDrug WHERE drug_id = ?',
        [monitorDrug.drug_id],
      );

      if (rowsAffected > 0) {
        // If rows were affected, the deletion was successful
        return ok;
      } else {
        // If no rows were affected, the user was not found
        return 'No user found with ID: ${monitorDrug.drug_id}';
      }
    } catch (error) {
      // Catch any error that occurs during the deletion
      print("Error: $error"); // Log the error for debugging
      return 'Error: $error';
    }
  }

  Future<String> deleteProgress(Progress progress) async {
    final db = await database;

    try {
      // Use a parameterized query to delete the user data by userId
      int rowsAffected = await db.rawDelete('DELETE FROM $progressTable');

      if (rowsAffected > 0) {
        // If rows were affected, the deletion was successful
        return ok;
      } else {
        // If no rows were affected, the user was not found
        return 'No user found with ID:';
      }
    } catch (error) {
      // Catch any error that occurs during the deletion
      print("Error: $error"); // Log the error for debugging
      return 'Error: $error';
    }
  }

  Future<String> deleteSecurity(Security security) async {
    final db = await database;

    try {
      // Use a parameterized query to delete the user data by userId
      int rowsAffected = await db.rawDelete('DELETE FROM $securityTable');

      if (rowsAffected > 0) {
        // If rows were affected, the deletion was successful
        return ok;
      } else {
        // If no rows were affected, the user was not found
        return 'No user found with ID:';
      }
    } catch (error) {
      // Catch any error that occurs during the deletion
      print("Error: $error"); // Log the error for debugging
      return 'Error: $error';
    }
  }
}

class UserDataResult {
  final UserData? userData;
  final String message;

  UserDataResult({this.userData, required this.message});
}

class MonitorDrugResult {
  final MonitorDrug? monitorDrug;
  final String message;

  MonitorDrugResult({this.monitorDrug, required this.message});
}

class ProgressResult {
  final Progress? progress;
  final String message;

  ProgressResult({this.progress, required this.message});
}

class SecurityResult {
  final Security? security;
  final String message;

  SecurityResult({this.security, required this.message});
}
