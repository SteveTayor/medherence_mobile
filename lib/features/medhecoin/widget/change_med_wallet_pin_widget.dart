import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:medherence/features/auth/widget/validation_extension.dart';

import '../../../core/constants/constants.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../../core/utils/size_manager.dart';

class ChangeMedWalletPin extends StatefulWidget {
  const ChangeMedWalletPin({super.key});

  @override
  State<ChangeMedWalletPin> createState() => _ChangeMedWalletPinState();
}

class _ChangeMedWalletPinState extends State<ChangeMedWalletPin> {
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmNewPinController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureNewPin = true;
  bool _obscureConfirmNewPin = true;
  void navigateBackToHome() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallet pin changed successfully'),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 10,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enhance Your Wallet Security: Change Yout PIN to Safeguard Your Earnings and Transactions.',
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: SizeMg.text(15),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'New Wallet Pin',
              style: TextStyle(
                fontSize: SizeMg.text(18),
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: SizeMg.height(5),
            ),
            TextFormField(
              controller: _newPinController,
              obscureText: _obscureNewPin,
              decoration: InputDecoration(
                // labelText: 'New Password',
                hintStyle: kFormTextDecoration.hintStyle,
                filled: false,
                fillColor: kFormTextDecoration.fillColor,
                errorBorder: kFormTextDecoration.errorBorder,
                border: kFormTextDecoration.border,
                focusedBorder: kFormTextDecoration.focusedBorder,
                hintText: "Enter your pin",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPin ? Icons.visibility_off : Icons.visibility,
                  ),
                  iconSize: SizeMg.radius(24),
                  onPressed: () {
                    setState(() {
                      _obscureNewPin = !_obscureNewPin;
                    });
                  },
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    4), // Limit input to 4 characters
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              keyboardType: TextInputType.number,
              validator: (value) {
                return value!.validatePin();
              },
            ),
            SizedBox(height: SizeMg.height(16)),
            Text(
              'Confirm New Wallet Pin',
              style: TextStyle(
                fontSize: SizeMg.text(18),
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: SizeMg.height(5),
            ),
            TextFormField(
              controller: _confirmNewPinController,
              obscureText: _obscureConfirmNewPin,
              decoration: InputDecoration(
                // labelText: 'New Password',
                hintStyle: kFormTextDecoration.hintStyle,
                filled: false,
                fillColor: kFormTextDecoration.fillColor,
                errorBorder: kFormTextDecoration.errorBorder,
                border: kFormTextDecoration.border,
                focusedBorder: kFormTextDecoration.focusedBorder,
                hintText: "Confirm your new wallet pin",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmNewPin
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  iconSize: SizeMg.radius(24),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmNewPin = !_obscureConfirmNewPin;
                    });
                  },
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    4), // Limit input to 4 characters
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != _newPinController.text) {
                  return 'Pin do not match.';
                }
                return null;
              },
            ),
            SizedBox(height: SizeMg.height(40)),
            PrimaryButton(
              buttonConfig: ButtonConfig(
                text: 'Save Pin',
                action: () {
                  navigateBackToHome();
                },
                disabled: false,
              ),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
