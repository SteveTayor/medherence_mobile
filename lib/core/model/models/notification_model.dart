import 'package:flutter/material.dart';
import '../simulated_data/simulated_values.dart';

class NotificationModel {
  final String id;
  final String title;
  final String subtitle;
  final bool read;
  final String notificationDate;

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.read,
    required this.notificationDate,
  });
}

class NotificationModelItems with ChangeNotifier {
  final List<NotificationModel> _notificationItemList = notificationLists;

  // NotificationModelItems(this._notificationItemList);

  List<NotificationModel> get notificationItemList => _notificationItemList;

  void removeNotification(String id) {
    final index = _notificationItemList
        .indexWhere((notification) => notification.id == id);
    if (index != -1) {
      _notificationItemList.removeAt(index);
      notifyListeners();
    }
  }
}
