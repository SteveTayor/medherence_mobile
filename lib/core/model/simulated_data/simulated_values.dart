import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medherence/core/model/models/history_model.dart';

import '../models/notification_model.dart';
import '../models/regimen_model.dart';

List<HistoryModel> generateSimulatedData() {
  List<RegimenDescriptionModel> regimenDescriptions =
      generateSimulatedRegimenDescriptions();
  final random = math.Random();

  return List.generate(5, (index) {
    IconData icon;
    switch (index % 3) {
      case 0:
        icon = Icons.medical_services;
        break;
      case 1:
        icon = Icons.healing;
        break;
      case 2:
        icon = Icons.medical_services;
        break;
      default:
        icon = Icons.local_hospital;
    }

    RegimenDescriptionModel regimenDescription =
        regimenDescriptions[index % regimenDescriptions.length];

    List<String> regimenNames = [
      'Omeprazole',
      'Lisinopril',
      'Azithromycin',
      'Rituximab'
    ];
    String randomRegimenName = regimenNames[index % 3];

    List<String> dosages = [
      '50mg, Take 2 pill',
      '150mg, Take 1 pill',
      '50mg, Take 1 pill'
    ];
    String randomDosage = dosages[index % 3];

    final now = DateTime.now();
    final notificationTime =
        TimeOfDay(hour: random.nextInt(12) + 1, minute: random.nextInt(60));
    DateTime yesterday = now.subtract(Duration(days: 2));
    DateTime fiveDaysFromNow = now.add(Duration(days: 3));

// Generate a random number of days within the desired range (1 to 5)
    int randomDays =
        random.nextInt(fiveDaysFromNow.difference(yesterday).inDays) + 1;

// Calculate the future date by adding the random days to yesterday
    final futureDateTime = yesterday.add(Duration(days: randomDays));
    // final futureDateTime = now.add(Duration(days: random.nextInt(30)));

    int id = index + 1;
    String message = '$randomDosage of $randomRegimenName medication';

    AdherenceStatus status;
    if (index % 3 == 0) {
      status = AdherenceStatus.early;
    } else if (index % 3 == 1) {
      status = AdherenceStatus.late;
    } else {
      status = AdherenceStatus.missed;
    }

    return HistoryModel(
      icon: icon,
      regimenName: randomRegimenName,
      dosage: randomDosage,
      date: futureDateTime,
      regimenDescription: regimenDescription,
      id: id,
      time: notificationTime,
      message: message,
      status: status,
    );
  });
}

List<RegimenDescriptionModel> generateSimulatedRegimenDescriptions() {
  return [
    RegimenDescriptionModel(
      medicationForm: 'Capsule',
      dose: '150 mg',
      pillTime: '2:00 pm',
      pillFrequency: 'Once a day',
      duration: '30 days',
      notes: 'To be taken before food',
    ),
    RegimenDescriptionModel(
      medicationForm: 'Capsule',
      dose: '60 mg',
      pillTime: '8:00 am',
      pillFrequency: 'Twice a day',
      duration: '14 days',
      notes: 'Take with plenty of water',
    ),
    RegimenDescriptionModel(
      medicationForm: 'Syrup',
      dose: '10 ml',
      pillTime: '9:00 pm',
      pillFrequency: 'Once a day',
      duration: '60 days',
      notes: 'Refrigerate after opening',
    ),
    RegimenDescriptionModel(
      medicationForm: 'Tablet',
      dose: '700 mg',
      pillTime: '9:00 pm',
      pillFrequency: 'Thrice a day',
      duration: '14 days',
      notes: 'To be taken after meal',
    ),
    // Add more simulated data here if needed
  ];
}

DateTime now = DateTime.now();

final formattedDate = DateFormat('dd/MM').format(now);

print(formattedDate) {
  // TODO: implement print
  throw UnimplementedError();
}

List<NotificationModel> notificationLists = [
  NotificationModel(
    id: "1",
    title: "Missed regimen",
    subtitle: "You did not take 2 tablets of Lisinopril",
    read: false,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "2",
    title: "Medhecoin",
    subtitle: "You have earned 10 Medhecoins",
    read: true,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "3",
    title: "Medhecoin",
    subtitle: "You have earned 120 Medhecoins",
    read: true,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "4",
    title: "Medhecoin",
    subtitle: "You have earned 100 Medhecoins",
    read: false,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "5",
    title: "Reminder",
    subtitle: "You have 2 tablets of Omeprazole left to use",
    read: false,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "6",
    title: "Medhecoin",
    subtitle: "You have earned 40 Medhecoins",
    read: true,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "7",
    title: "Motivation",
    subtitle:
        "Taking your medication as prescribed is a crucial step in managing your health and well-being",
    read: true,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "8",
    title: "Motivation",
    subtitle:
        "Taking your medication as prescribed is a crucial step in managing your health and well-being",
    read: true,
    notificationDate: formattedDate,
  ),
  NotificationModel(
    id: "9",
    title: "Motivation",
    subtitle:
        "Ensuring a proper intake of medication fastening a good stable and quick growth",
    read: false,
    notificationDate: formattedDate,
  ),
  // Add more NotificationModel objects as needed
];
