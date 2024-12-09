import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/model/models/notification_model.dart';

class NotificationWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const NotificationWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationList =
        Provider.of<NotificationModelItems>(context, listen: false)
            .notificationItemList;
    int notificationCount = notificationList.length;
    if (notificationCount < 1) {
      return IconButton(
        icon: const Icon(
          CupertinoIcons.bell,
          color: AppColors.navBarColor,
        ),
        onPressed: onPressed,
      );
    }
    return Badge(
      alignment: const AlignmentDirectional(0.2, -0.5),
      smallSize: 5,
      label: const Icon(
        Icons.circle_rounded,
        color: AppColors.red,
        size: 8,
      ),
      //elevation: 0,
      backgroundColor: AppColors.white,
      child: IconButton(
        icon: const Icon(
          CupertinoIcons.bell,
          color: AppColors.navBarColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
