import 'dart:typed_data';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medherence/core/model/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../model/simulated_data/simulated_values.dart';
import '../../features/dashboard_feature/view/dashboard_view.dart';

class NotificationService extends ChangeNotifier {
  late SharedPreferences preferences;

  List<HistoryModel> modelList = generateSimulatedData();

  // List<HistoryModel> get modelList => modelList;

  List<String> listofstring = [];

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  late BuildContext context; // Define context here

  // Constructor to pass the BuildContext
  NotificationService();

  /// Initialize the notification service.
  ///
  /// This method initializes the local notifications plugin with settings for both Android and iOS.
  /// It also schedules alarms from saved reminders.
  Future<void> init() async {
    var androidInitilize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = const DarwinInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!.initialize(initilizationsSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    // Schedule alarms from saved reminders
    await scheduleAlarmsFromSavedReminders();
  }

  /// Handles notification response.
  ///
  /// This method handles the action to be performed when a notification is received.
  /// It navigates to the dashboard view upon receiving a notification.
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DashboardView()));
  }

  /// Displays a notification immediately.
  ///
  /// This method configures and shows a notification with the specified details.
  ShowNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Alarm channel',
      'Alarms ',
      channelDescription: 'Alarm Notification',
      importance: Importance.max,
      priority: Priority.high,
      sound: const RawResourceAndroidNotificationSound('alarm'),
      autoCancel: false,
      playSound: true,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
      audioAttributesUsage: AudioAttributesUsage.alarm,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      fullScreenIntent: true,
      additionalFlags: Int32List.fromList(<int>[
        0x00000001, // FLAG_INSISTENT (Requires VIBRATE permission)
      ]),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin!.show(
      0, // Use the ID of the HistoryModel as the notification ID
      'plain title', // Use the regimen name as the notification title
      'plain body',
      notificationDetails,
      payload: 'item x',
    );
    notifyListeners();
  }

  /// Schedules alarms from saved reminders.
  ///
  /// This method iterates through the list of reminders and schedules notifications for each.
  Future<void> scheduleAlarmsFromSavedReminders() async {
    for (var reminder in modelList) {
      scheduleNotification(reminder);
      debugPrint('reminder in the model list is : $reminder');
      debugPrint('alarms scheduled successfully!!!!!!');
    }
    notifyListeners();
  }

  /// Schedules a notification for a specific reminder.
  ///
  /// This method schedules a notification to be shown at the time specified in the reminder.
  Future<void> scheduleNotification(HistoryModel reminder) async {
    int notificationId = reminder.id;
    final now = DateTime.now();
    var futureDateTime = reminder.date;

    if (futureDateTime.isBefore(now)) {
      return;
    }
    int newTime = futureDateTime.millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch;
    debugPrint('future time is: $futureDateTime');
    debugPrint('The new time is: $newTime');
    await flutterLocalNotificationsPlugin?.zonedSchedule(
      notificationId,
      'Alarm',
      reminder.message,
      tz.TZDateTime.now(tz.local).add(Duration(milliseconds: newTime)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'med id',
          'medherence',
          channelDescription: 'Medical adherence reminder',
          sound: const RawResourceAndroidNotificationSound('alarm'),
          autoCancel: false,
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          audioAttributesUsage: AudioAttributesUsage.alarm,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
          fullScreenIntent: true,
          additionalFlags: Int32List.fromList(
            <int>[
              0x00000001, // FLAG_INSISTENT (Requires VIBRATE permission)
            ],
          ),
        ),
      ),
      payload: notificationId.toString(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    notifyListeners();
  }

  /// Cancels a scheduled notification.
  ///
  /// This method cancels a scheduled notification with the specified notification ID.
  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin!.cancel(notificationId);
  }

  /// Stops the alarm action for a specific notification.
  ///
  /// This method stops the alarm associated with the given notification ID.
  Future<void> stopAlarmAction(int notificationId) async {
    await AndroidAlarmManager.cancel(notificationId);
  }
}
