import 'package:flutter/material.dart';
import 'regimen_model.dart';

enum AdherenceStatus {
  early,
  late,
  missed,
}

class HistoryModel {
  IconData icon;
  String regimenName;
  String dosage;
  DateTime date;
  RegimenDescriptionModel regimenDescription;
  int id;
  TimeOfDay time;
  String message;
  AdherenceStatus status;

  HistoryModel({
    required this.icon,
    required this.regimenName,
    required this.dosage,
    required this.date,
    required this.regimenDescription,
    required this.id,
    required this.time,
    required this.message,
    required this.status,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    // Adjusting the parsing for 'time' field
    List<String> timeParts = json['time'].split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    return HistoryModel(
      icon: IconData(int.parse(json['icon'].toString()),
          fontFamily: 'MaterialIcons'),
      regimenName: json['regimenName'],
      dosage: json['dosage'],
      date: DateTime.parse(json['date']),
      regimenDescription:
          RegimenDescriptionModel.fromJson(json['regimenDescription']),
      id: json['id'],
      time: TimeOfDay(hour: hour, minute: minute),
      message: json['message'],
      status: AdherenceStatus.values[int.parse(json['status'].toString())],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon.codePoint,
      'regimenName': regimenName,
      'dosage': dosage,
      'date': date.toIso8601String(),
      'regimenDescription': regimenDescription.toJson(),
      'id': id,
      'time': '${time.hour}:${time.minute}',
      'message': message,
      'status': status.index,
    };
  }
}
