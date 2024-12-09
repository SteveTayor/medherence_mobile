import 'package:flutter/material.dart';
import 'package:medherence/features/auth/widget/validation_extension.dart';

import '../../../core/constants/constants.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';
import 'change_med_wallet_pin_widget.dart';

class MedWalletPin extends StatefulWidget {
  const MedWalletPin({super.key});

  @override
  State<MedWalletPin> createState() => _MedWalletPinState();
}

class _MedWalletPinState extends State<MedWalletPin> {
  final TextEditingController _passwordController = TextEditingController();
  bool _showChangePinView = false;
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  void navigateBackToHome() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showChangePinView = true; // Show ChangeMedWalletPin
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.green,
          duration: Duration(seconds: 5),
          content: Text('Password verified successfully'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Wallet Pin',
          style: TextStyle(
            fontSize: SizeMg.text(25),
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins-bold.ttf",
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: _showChangePinView == true
          ? const ChangeMedWalletPin() // Show ChangeMedWalletPin if _showChangePinView is true
          : Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your account password to verify that it is you',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: SizeMg.text(15),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        // labelText: 'New Password',
                        hintStyle: kFormTextDecoration.hintStyle,
                        filled: false,
                        fillColor: kFormTextDecoration.fillColor,
                        errorBorder: kFormTextDecoration.errorBorder,
                        border: kFormTextDecoration.border,
                        focusedBorder: kFormTextDecoration.focusedBorder,
                        hintText: "Type in your password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          iconSize: SizeMg.radius(24),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        return value!.validatePassword();
                      },
                    ),
                    SizedBox(height: SizeMg.height(30)),
                    PrimaryButton(
                      width: double.infinity,
                      buttonConfig: ButtonConfig(
                        text: 'Verify',
                        action: () async {
                          navigateBackToHome();
                        },
                        disabled: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
