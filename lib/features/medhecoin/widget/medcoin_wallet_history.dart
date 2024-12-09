import 'package:flutter/material.dart';

import '../../../core/model/models/wallet_model.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../../../core/utils/utils.dart';

class MedhecoinWalletHistory extends StatelessWidget {
  final WalletModel model;

  const MedhecoinWalletHistory({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return SizedBox(
      child: ListTile(
        leading: CircleAvatar(
          radius: SizeMg.radius(30),
          child: Image.asset(model.src, width: 55, fit: BoxFit.fitHeight),
        ),
        title: Text(
          model.title,
        ),
        titleTextStyle: TextStyle(
          fontSize: SizeMg.text(16),
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        subtitle: Row(
          children: [
            Text(
              StringUtils.formatTime12(DateTime.parse(model.dateTime)),
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: CircleAvatar(
                radius: 2,
                backgroundColor: AppColors.black,
              ),
            ),
            Text(
              StringUtils.checkToday(DateTime.parse(model.dateTime)),
            )
          ],
        ),
        subtitleTextStyle: TextStyle(
            fontSize: SizeMg.text(12),
            fontWeight: FontWeight.w400,
            color: AppColors.darkGrey,
            overflow: TextOverflow.ellipsis),
        trailing: RichText(
          text: TextSpan(
            text: model.debit ? '-\u{20A6}' : '+\u{20A6}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: SizeMg.text(14),
              color: model.debit ? AppColors.red : AppColors.green,
            ),
            children: [
              TextSpan(
                text: StringUtils.numFormatDecimal(model.price),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
