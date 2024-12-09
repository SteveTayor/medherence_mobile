import 'package:flutter/material.dart';
import 'package:medherence/core/shared_widget/buttons.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/size_manager.dart';
import '../../../core/model/models/wallet_model.dart';
import '../../dashboard_feature/view/dashboard_view.dart';
import '../../medhecoin/view_model/medhecoin_wallet_view_model.dart';
import '../../profile/view_model/profile_view_model.dart';

class MedCoinDropWidget extends StatelessWidget {
  final int medhecoinEarned;

  const MedCoinDropWidget({Key? key, required this.medhecoinEarned})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Well-done Champ!!!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ),
      content: SizedBox(
        height: SizeMg.height(300),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/coin_drop.png',
                height: SizeMg.height(200),
                width: SizeMg.width(250),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                    text: 'You have earned ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.darkGrey,
                    ),
                    children: [
                      TextSpan(
                        text: '$medhecoinEarned',
                        style: const TextStyle(
                          color: AppColors.navBarColor,
                        ),
                      ),
                      const TextSpan(
                        text: ' Medhecoin',
                      ),
                    ]),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomCenter,
                child: OutlinePrimaryButton(
                  width: 200,
                  textSize: SizeMg.text(16),
                  buttonConfig: ButtonConfig(
                    text: 'Yaayy!!!',
                    action: () {
                      // final walletViewModel =
                      //     Provider.of<WalletViewModel>(context, listen: false);
                      final profile =
                          Provider.of<ProfileViewModel>(context, listen: false);
                      // Create a new transaction model
                      final newTransaction = WalletModel(
                        firstName: profile.nickName.isNotEmpty
                            ? profile.nickName
                            : 'ADB', // Replace with actual data
                        lastName: '', // Replace with actual data
                        src:
                            'assets/images/bank_logo/medherence_icon.png', // Replace with actual data
                        title: 'Adherence Bonus',
                        dateTime: DateTime.now()
                            .toString(), // Use the current date and time
                        price: medhecoinEarned.toDouble(),
                        debit: false,
                      );

                      // Add the new transaction to the wallet model list
                      Provider.of<WalletViewModel>(context, listen: false)
                          .addTransaction(newTransaction);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const DashboardView()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
