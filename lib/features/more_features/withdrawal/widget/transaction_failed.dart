import 'package:flutter/material.dart';
import 'package:medherence/core/utils/size_manager.dart';
import 'package:medherence/features/dashboard_feature/view/dashboard_view.dart';

import '../../../../core/shared_widget/buttons.dart';
import '../../../../core/utils/color_utils.dart';

class FailedTransaction extends StatelessWidget {
  const FailedTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction Failed',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/transaction failure.png',
                    width: SizeMg.width(60),
                    height: SizeMg.height(60),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'We\'re sorry, the transaction could not be processed at this time try again',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: SizeMg.text(14),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              child: PrimaryButton(
                buttonConfig: ButtonConfig(
                    text: 'Go to Dashboard',
                    action: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const DashboardView(),
                          ),
                          (route) => false);
                    }),
                width: SizeMg.screenWidth - 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
