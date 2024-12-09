import 'package:jiffy/jiffy.dart';

import '../constants/constants.dart';

class StringUtils {
  static String poppins = 'Poppins';
  static const String kWalletModelsKey = 'wallet_models';
  static const String kSavedWithdrawalAccountsKey = 'saved_withdrawal_accounts';

  static String formatDateTime(DateTime dateTime) {
    // Format the date and time as required
    return Jiffy.parseFromDateTime(dateTime).format(pattern: 'hh:mma');
  }

  // static String formatDate(DateTime dateTime) {
  //   // Format the date and time as required
  //   return Jiffy.parseFromDateTime(dateTime).format(pattern: 'dd/MM/yy');
  // }

  static String checkToday(DateTime time) {
    // Jiffy today = Jiffy.now();
    Jiffy dateTime = Jiffy.parseFromDateTime(time);
    // if (dateTime.isSame(today, unit: Unit.day)) {
    //   return 'Today';
    // }
    return dateTime.format(pattern: 'dd/MM/yyyy');
  }

  static String checkTime(DateTime time) {
    Jiffy today = Jiffy.now();
    Jiffy dateTime = Jiffy.parseFromDateTime(time);
    num dateDiffSec = today.diff(dateTime, unit: Unit.second);
    //Checking if its less than a minute
    if (dateDiffSec < 60) {
      return '$dateDiffSec seconds ago';
    }
    //Checking if its less than an hour
    else if (dateDiffSec < 3600) {
      int dateDiffMin = dateDiffSec ~/ 60;
      return '$dateDiffMin mins ago';
    }
    //Checking if its less than a day
    else if (dateDiffSec < 86400) {
      int dateDiffHr = dateDiffSec ~/ 3600;
      return '$dateDiffHr hrs ago';
    }
    //Checking if its less than 2 days
    else if (dateDiffSec < 172800) {
      int dateDiffDay = dateDiffSec ~/ 86400;
      return '$dateDiffDay days ago';
    }
    return dateTime.format(pattern: 'EEEE, do MMMM, yyyy');
  }

  static String numFormatNoDecimal(dynamic number) {
    return kNumFormatNoDecimal.format(number);
  }

  static String numFormatDecimal(dynamic number) {
    return kNumFormatDecimal.format(number);
  }

  static String formatCompletedPaymentDate(DateTime dateTime) {
    return Jiffy.parseFromDateTime(dateTime)
        .format(pattern: 'do MMM, yyyy h:mm a');
  }

  static String timeDiffInMinutes(DateTime before, DateTime after) {
    Jiffy departure = Jiffy.parseFromDateTime(before);
    Jiffy arrival = Jiffy.parseFromDateTime(after);
    return '${arrival.diff(departure, unit: Unit.minute)}';
  }

  static String formatTime12(DateTime dateTime) {
    ///Format date time into 12hr time format using Jiffy package
    return Jiffy.parseFromDateTime(dateTime).format(pattern: 'h:mm a');
  }
}
