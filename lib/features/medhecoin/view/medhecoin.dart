import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medherence/core/utils/size_manager.dart';
import 'package:medherence/features/dashboard_feature/view/dashboard_view.dart';
import 'package:medherence/features/more_features/withdrawal/view/withdrawal_view.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../home/widget/medecoin_widget.dart';
import '../../monitor/view_model/reminder_view_model.dart';
import '../../more_features/withdrawal/view/add_account_view.dart';
import '../view_model/medhecoin_wallet_view_model.dart';
import '../widget/med_wallet_pin_widget.dart';
import '../widget/medcoin_wallet_history.dart';

class MedhecoinScreen extends StatefulWidget {
  const MedhecoinScreen({super.key});

  @override
  State<MedhecoinScreen> createState() => _MedhecoinScreenState();
}

class _MedhecoinScreenState extends State<MedhecoinScreen> {
  bool _amountChanged = false; // Track if amount display is changed

  // Toggle function for changing amount display
  void toggleAmountChanged() {
    setState(() {
      _amountChanged = !_amountChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    ReminderState reminderState = Provider.of<ReminderState>(context);

    // Retrieve Medhecoin balance and amount in Naira from provider
    int medcoinBalance = reminderState.medcoin;
    double medcoinInNaira = reminderState.medcoinInNaira;

    // Determine displayed title and amount based on toggle state
    String coinTitle = _amountChanged ? 'Amount in Naira' : 'Amount in MDHC';
    String amount = _amountChanged
        ? medcoinInNaira.toStringAsFixed(2)
        : medcoinBalance.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medhecoin',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Navigate back to DashboardView on back arrow tap
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const DashboardView()),
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CupertinoButton(
              onPressed: () {
                // Navigate to MedWalletPin on settings button tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MedWalletPin()),
                );
              },
              child: const Icon(
                CupertinoIcons.gear_alt_fill,
                color: AppColors.pillIconColor,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<WalletViewModel>(
        builder: (context, model, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Display Medhecoin amount widget with toggle functionality
                MedhecoinWidget(
                  onTap: toggleAmountChanged,
                  iconData: null,
                  onPressed: null,
                  amountChanged: _amountChanged,
                  coinTitle: coinTitle,
                  amount: amount,
                ),
                const SizedBox(height: 15),
                // Display progress and withdrawal chances
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Progress display
                        RichText(
                          text: const TextSpan(
                            text: 'Progress:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            children: [
                              TextSpan(
                                text: ' 0', // Placeholder for actual progress
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(
                                text: '/30', // Placeholder for total progress
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 50),
                        // Withdrawal chances display
                        RichText(
                          text: const TextSpan(
                            text: 'Withdrawal Chances:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            children: [
                              TextSpan(
                                text: ' 0', // Placeholder for actual chances
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Buttons for Withdrawal and Add Account actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinePrimaryButton(
                        textSize: 18,
                        buttonConfig: ButtonConfig(
                          text: 'Withdraw',
                          action: () {
                            // Navigate to MedhecoinWithdrawalView on Withdraw button tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const MedhecoinWithdrawalView())),
                            );
                          },
                          disabled: false,
                        ),
                        // Withdrawal button with icon and text
                        child: Image.asset(
                          'assets/images/withdrawal_icon.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinePrimaryButton(
                        textSize: 18,
                        icon: Icons.add,
                        buttonConfig: ButtonConfig(
                          text: 'Add Account',
                          action: () {
                            // Navigate to AddAccountView on Add Account button tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const AddAccountView())),
                            );
                          },
                          disabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Display transaction history list
                const Text(
                  'History',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: SizeMg.height(10),
                    bottom: SizeMg.height(16),
                  ),
                  itemBuilder: (ctx, index) => MedhecoinWalletHistory(
                    model: model.walletModelList[index],
                  ),
                  separatorBuilder: (ctx, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: model.walletModelList.length,
                ),
                // Display message when transaction history is empty
                if (model.walletModelList.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 170),
                      child: SizedBox(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              color: AppColors.noWidgetText,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'You have no transaction history',
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: AppColors.noWidgetText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
