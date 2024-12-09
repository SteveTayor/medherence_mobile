import 'package:flutter/material.dart';
import 'package:medherence/features/auth/widget/validation_extension.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../../core/utils/size_manager.dart';
import '../widget/textfield.dart';
import 'verify_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController phoneController;
  Color emailFillColor = Colors.white70;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController = TextEditingController();
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
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeMg.width(20.0),
            right: SizeMg.width(20),
            top: SizeMg.height(100),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.textFilledColor.withOpacity(0.5),
                    radius: 51,
                    child: CircleAvatar(
                      backgroundColor: AppColors.textFilledColor,
                      radius: 45,
                      child: Icon(
                        Icons.vertical_split_outlined,
                        size: SizeMg.radius(24),
                        color: AppColors.navBarColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: SizeMg.text(24),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeMg.width(20),
                    ),
                    child: Text(
                      'Don’t worry! Please enter your associated whatsapp phone number, we would send you reset instructions.',
                      style: TextStyle(
                        fontSize: SizeMg.text(15),
                        fontWeight: FontWeight.w300,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TitleAndTextFormField(
                    title: 'Phone Number',
                    formFieldHint: 'Please type your phone number',
                    formFieldController: phoneController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    formFieldColor: emailFillColor,
                    formFieldValidator: (value) {
                      return value!.phoneNumberValidation();
                    },
                  ),
                  const SizedBox(height: 35),
                  PrimaryButton(
                    buttonConfig: ButtonConfig(
                      text: 'Send',
                      action: () {
                        if (_formKey.currentState!.validate()) {
                          // Password change logic goes here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Otp sent'),
                              backgroundColor: AppColors.green,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyForgotPassword(
                                phoneNumber: phoneController.text,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              dismissDirection: DismissDirection.horizontal,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                top: 0,
                                left: 25,
                                right: 25,
                                bottom: 35,
                              ),
                              content:
                                  Text('Ensure to input a valid phone number'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      disabled: false,
                    ),
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
