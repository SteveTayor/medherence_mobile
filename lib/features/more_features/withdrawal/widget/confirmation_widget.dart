import 'package:flutter/material.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:medherence/core/utils/size_manager.dart';

import '../../../../core/shared_widget/buttons.dart';
import '../../Biometric/widget/biometric_widget.dart';
import '../../wallet/widget/wallet_pin_widget.dart';

class ConfirmWithdrawal extends StatelessWidget {
  final String amount;
  final String transferFee;
  final String totalAmount;
  final String receiverName;
  final String bankName;
  final String amountEquivalence;
  final String dateTime;

  const ConfirmWithdrawal({
    Key? key,
    required this.amount,
    required this.transferFee,
    required this.totalAmount,
    required this.receiverName,
    required this.bankName,
    required this.amountEquivalence,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Transaction Amount',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '$totalAmount MDHC',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.navBarColor,
                  fontSize: SizeMg.text(25),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '~ \u{20A6}$amountEquivalence',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.historyBackground,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeMg.text(14),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: AppColors.historyBackground,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  leading: Text(
                    'To',
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: SizeMg.text(16),
                    ),
                  ),
                  trailing: Text(
                    receiverName,
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.historyBackground,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  leading: Text(
                    'Bank ',
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: SizeMg.text(16),
                    ),
                  ),
                  trailing: Text(
                    bankName,
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.historyBackground,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  leading: Text(
                    'Fee',
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: SizeMg.text(16),
                    ),
                  ),
                  trailing: Text(
                    '$transferFee MDHC',
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.historyBackground,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  leading: Text(
                    'Date',
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: SizeMg.text(16),
                    ),
                  ),
                  trailing: Text(
                    dateTime,
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.historyBackground,
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: PrimaryButton(
                  height: SizeMg.height(48),
                  buttonConfig: ButtonConfig(
                    text: 'Confirm',
                    action: () {
                      showDialog(
                        // barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const WalletPinWidget(),
                              const SizedBox(height: 15),
                              Text(
                                'Or',
                                style: TextStyle(
                                  fontSize: SizeMg.text(22),
                                  color: AppColors.historyBackground,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const BiometricWidget(),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  width: SizeMg.screenWidth,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
