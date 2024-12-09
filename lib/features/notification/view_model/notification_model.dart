import 'package:stacked/stacked.dart';

import '../../../core/model/models/notification_model.dart';

class NotificationViewModel extends BaseViewModel {
  late final List<NotificationModel> _listNotification;

  NotificationViewModel(this._listNotification);

  List<NotificationModel>? get notificationList {
    return _listNotification;
  }
}
