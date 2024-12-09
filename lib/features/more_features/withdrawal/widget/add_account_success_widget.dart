import 'package:flutter/material.dart';
import 'package:medherence/core/shared_widget/buttons.dart';
import 'package:medherence/features/medhecoin/view/medhecoin.dart';

import '../../../../core/utils/color_utils.dart';
import '../../../../core/utils/size_manager.dart';

class AddAccountSuccessfulWidget extends StatelessWidget {
  const AddAccountSuccessfulWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Successful',
          style: TextStyle(
            fontSize: 25,
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
                    'assets/images/transaction check.png',
                    width: SizeMg.width(100),
                    height: SizeMg.height(100),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'You have successfully added account',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: SizeMg.text(16),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              child: PrimaryButton(
                buttonConfig: ButtonConfig(
                    text: 'Go to Wallet',
                    action: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const MedhecoinScreen(),
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
