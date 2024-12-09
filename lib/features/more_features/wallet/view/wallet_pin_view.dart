import 'package:flutter/material.dart';
import 'package:medherence/features/auth/widget/validation_extension.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/shared_widget/buttons.dart';
import '../../../../core/utils/size_manager.dart';
import 'change_pin_view.dart';

class WalletPinView extends StatefulWidget {
  const WalletPinView({super.key});

  @override
  State<WalletPinView> createState() => _WalletPinViewState();
}

class _WalletPinViewState extends State<WalletPinView> {
  final TextEditingController _passwordController = TextEditingController();
  bool _showChangePinView = false;
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet Pin',
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
          ? const ChangeWalletPinView() // Show ChangeWalletPinView if _showChangePinView is true
          : Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 10,
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Enter your account password to verify that it is you'),
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
                          setState(() {
                            _showChangePinView =
                                true; // Show ChangeWalletPinView
                          });
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
