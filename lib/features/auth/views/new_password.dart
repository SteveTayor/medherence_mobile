import 'package:flutter/material.dart';
import 'package:medherence/features/auth/views/login_view.dart';
import 'package:medherence/features/auth/widget/validation_extension.dart';


import '../../../core/utils/color_utils.dart';
import '../../../core/constants/constants.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../../core/utils/size_manager.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Function to update shared preferences when password is successfully changed
  // Future<void> updatePasswordChangedFlag() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('passwordChanged', true);
  // }

  // Function to check if password has been successfully changed
  // Future<bool> isPasswordChanged() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('passwordChanged') ?? false;
  // }

  // Function to navigate back to home screen after password change
  void navigateBackToHome() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginView()),
    // );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginView()),
        (Route<dynamic> route) => false);
  }

  // Your validation logic and save password logic here...

  // Function to handle password change submission
  // void handlePasswordChange() {
  //   if (_formKey.currentState!.validate()) {
  //     // Perform password change logic here...
  //     // If password change is successful, update shared preferences
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Password changed successfully')),
  //     );
  //     updatePasswordChangedFlag().then((_) {
  //       // Navigate back to home screen
  //       navigateBackToHome();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: SizeMg.text(25),
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          '* Use a combination of uppercase and lowercase letters. \n',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: SizeMg.text(12),
                      ),
                      children: const [
                        TextSpan(
                          text: '* Include at least one number (0-9).\n',
                        ),
                        TextSpan(
                          text:
                              '*  Include at least one special character (e.g., !, @, #, \$, %, ^, &, *). \n',
                        ),
                        TextSpan(
                          text:
                              '* Avoid using easily guessable information, such as your name, username, or common words. \n',
                        ),
                        TextSpan(
                            text:
                                '* Aim for a minimum length of 8 characters, but longer passwords are generally more secure.'),
                      ],
                    ),
                    textScaler: const TextScaler.linear(1.15),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: SizeMg.text(18),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: SizeMg.height(10),
                  ),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _obscureNewPassword,
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
                          _obscureNewPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        iconSize: SizeMg.radius(24),
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      return value!.validatePassword();
                    },
                  ),
                  SizedBox(height: SizeMg.height(16)),
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: SizeMg.text(18),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: SizeMg.height(10),
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      // labelText: 'Confirm Password',
                      hintStyle: kFormTextDecoration.hintStyle,
                      filled: false,
                      fillColor: kFormTextDecoration.fillColor,
                      errorBorder: kFormTextDecoration.errorBorder,
                      border: kFormTextDecoration.border,
                      focusedBorder: kFormTextDecoration.focusedBorder,
                      hintText: "Type in your password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        iconSize: SizeMg.radius(24),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeMg.height(40)),
                  PrimaryButton(
                    buttonConfig: ButtonConfig(
                      text: 'Save Password',
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
          ],
        ),
      ),
    );
  }
}
