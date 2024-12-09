import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../../core/utils/size_manager.dart';
import '../widget/otp_tile.dart';
import 'new_password.dart';

class VerifyForgotPassword extends StatefulWidget {
  String phoneNumber;
  VerifyForgotPassword({required this.phoneNumber, super.key});

  @override
  State<VerifyForgotPassword> createState() => _VerifyForgotPasswordState();
}

class _VerifyForgotPasswordState extends State<VerifyForgotPassword> {
  late final List<TextEditingController> _otpControllers;
  int _resendTimer = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (index) => TextEditingController());
    startResendTimer();
  }

  void startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  bool get isFormValid {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeMg.width(20),
          right: SizeMg.width(20),
          top: SizeMg.height(100),
        ),
        child: Center(
          child: ListView(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.textFilledColor.withOpacity(0.5),
                radius: 51,
                child: CircleAvatar(
                  backgroundColor: AppColors.textFilledColor,
                  radius: SizeMg.radius(24),
                  child: const Icon(
                    Icons.mark_email_unread_outlined,
                    size: 30,
                    color: AppColors.navBarColor,
                  ),
                ),
              ),
              SizedBox(
                height: SizeMg.height(50),
              ),
              Text(
                'Check your mail!',
                style: TextStyle(
                  fontSize: SizeMg.text(35),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeMg.height(10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeMg.width(20),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'We sent a 4-digit code to',
                    style: TextStyle(
                      fontSize: SizeMg.text(17),
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600,
                    ),
                    children: [
                      TextSpan(
                        text: ' ${widget.phoneNumber}',
                        style: TextStyle(
                          fontSize: SizeMg.text(17),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: SizeMg.height(25),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 8.0),
                child: SizedBox(
                  height: SizeMg.height(120),
                  width: MediaQuery.of(context).size.width - 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: SizeMg.width(7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _otpControllers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final controller = entry.value;
                        return Row(
                          children: [
                            OtpTile(
                              index: index,
                              otpSaved: () {},
                              numberController: controller,
                            ),
                            SizedBox(
                              width: SizeMg.width(10),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeMg.height(10),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(11.0, 8.0, 6.0, 8.0),
                child: PrimaryButton(
                  width: double.infinity,
                  buttonConfig: ButtonConfig(
                    text: 'Verify',
                    action: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewPassword()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Otp verified successfully'),
                          backgroundColor: AppColors.green,
                        ),
                      );
                    },
                    disabled: !isFormValid,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Didn’t receive the email? ',
                    style: TextStyle(
                      fontSize: SizeMg.text(15),
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Resend($_resendTimer)',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Function to show SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Otp resent successfully'),
                                backgroundColor: AppColors.green,
                              ),
                            );
                            setState(() {
                              _resendTimer = 60;
                            });
                          },
                        style: TextStyle(
                          fontSize: SizeMg.text(15),
                          fontWeight: FontWeight.w500,
                          color: AppColors.navBarColor,
                        ),
                      )
                    ]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
