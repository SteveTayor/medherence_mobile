import 'package:flutter/material.dart';
import 'package:medherence/core/shared_widget/buttons.dart';
import 'package:medherence/features/auth/views/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/size_manager.dart';
import '../widget/textfield.dart';
import '../../dashboard_feature/view/dashboard_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController hospitalNumberController;
  late TextEditingController passwordController;
  final TextEditingController _dropDownSearchController =
      TextEditingController();
  String? _selectedHospital;
  bool obscurePassword = false;
  bool _rememberMe = false;
  Color? hospitalNumberFillColor = Colors.white70;
  Color? passwordFillColor = Colors.white70;
  Color? dropdownFill;
  final _formKey = GlobalKey<FormState>();

  Future<void> signingIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', true);
  }

  void navigateBackToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardView()),
    );
  }

  void handleSignIn() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed In successfully')),
      );
      signingIn().then((_) {
        navigateBackToHome();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          dismissDirection: DismissDirection.horizontal,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(15),
          content: Text('Oops, you have inputted the wrong login details.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String? selectedHospital;
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  static final List<String> hospitalNames = [
    'Hospital A',
    'Hospital B',
    'Hospital C',
    'Hospital D',
    'Hospital E',
    'Hospital F',
    'Hospital G',
    'Hospital H',
    'Hospital I',
    'Hospital J',
    'Willowbrook General Hospital',
    'Havenridge Medical Center',
    'Serenity Health Clinic',
    'Crestview Regional Hospital',
    'Oakwood Community Hospital',
    'Meadowbrook Memorial Hospital',
    'Summitview Medical Center',
    'Pinecrest Hospital',
    'Harborview Healthcare Center',
    'Maplewood Clinic',
    'Sunridge Regional Hospital',
    'Lakeside Medical Center',
    'Rosewood General Hospital',
    'Valleyview Health Services',
    'Greenfield Community Hospital',
    'Riverside Medical Center',
    'Brookside Clinic',
    'Clearwater Hospital',
    'Mountainview Healthcare Center',
    'Fairview Regional Hospital'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(hospitalNames);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void initState() {
    super.initState();
    hospitalNumberController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            fontSize: SizeMg.text(30),
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins-bold.ttf",
          ),
        ),
        centerTitle: true,
        toolbarHeight: SizeMg.height(100),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeMg.width(25),
          right: SizeMg.width(25),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: SizeMg.text(25),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins-bold.ttf",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Enter your login details to access the app',
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins-bold.ttf",
                  color: AppColors.darkGrey,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Hospital/Clinical Name',
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              DropDownSearchFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _dropDownSearchController,
                  decoration: kFormTextDecoration.copyWith(
                    errorBorder: kFormTextDecoration.errorBorder,
                    hintStyle: kFormTextDecoration.hintStyle,
                    hintText: 'Select your HCP',
                    filled: true,
                    fillColor: dropdownFill,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    border: kFormTextDecoration.border,
                    focusedBorder: kFormTextDecoration.focusedBorder,
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  _dropDownSearchController.text = suggestion;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a hospital';
                  }
                  setState(() {
                    dropdownFill = value.isNotEmpty
                        ? kFormTextDecoration.fillColor
                        : Colors.white70;
                  });
                  return null;
                },
                onReset: () {
                  setState(() {
                    dropdownFill = selectedHospital != null
                        ? kFormTextDecoration.fillColor
                        : Colors.white70;
                  });
                },
                onSaved: (value) {
                  selectedHospital = value;
                  setState(() {
                    dropdownFill = selectedHospital != null
                        ? kFormTextDecoration.fillColor
                        : Colors.white70;
                  });
                },
                displayAllSuggestionWhenTap: true,
              ),
              SizedBox(height: SizeMg.height(20)),
              TitleAndTextFormField(
                title: 'Hospital Number',
                formFieldHint: 'Please type your Hospital Number',
                formFieldController: hospitalNumberController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                formFieldColor: hospitalNumberFillColor,
                formFieldValidator: (value) {
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    hospitalNumberFillColor = value.isNotEmpty
                        ? kFormTextDecoration.fillColor
                        : Colors.white70;
                  });
                },
              ),
              SizedBox(height: SizeMg.height(20)),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: SizeMg.height(10)),
              TextFormField(
                obscureText: !obscurePassword,
                controller: passwordController,
                cursorHeight: SizeMg.height(19),
                decoration: kFormTextDecoration.copyWith(
                  errorBorder: kFormTextDecoration.errorBorder,
                  hintStyle: kFormTextDecoration.hintStyle,
                  filled: true,
                  fillColor: passwordFillColor,
                  border: kFormTextDecoration.border,
                  focusedBorder: kFormTextDecoration.focusedBorder,
                  hintText: "Type in your password",
                  suffixIcon: IconButton(
                    icon: obscurePassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.remove_red_eye_rounded),
                    iconSize: 24,
                    onPressed: () => setState(() {
                      obscurePassword = !obscurePassword;
                    }),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "The password field must cannot be empty";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    passwordFillColor = value.isNotEmpty
                        ? kFormTextDecoration.fillColor
                        : Colors.white70;
                  });
                },
              ),
              SizedBox(height: SizeMg.height(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  const Text(
                    'Remember Me',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.navBarColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeMg.height(20)),
              PrimaryButton(
                width: double.infinity,
                buttonConfig: ButtonConfig(
                  text: 'Sign In',
                  action: () {
                    handleSignIn();
                  },
                  disabled: (_selectedHospital == '' ||
                      hospitalNumberController.text.isEmpty ||
                      passwordController.text.isEmpty),
                ),
              ),
              SizedBox(height: SizeMg.height(30)),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: SizeMg.width(8)),
                    child: Icon(
                      Icons.feedback_rounded,
                      color: Colors.blue.shade200,
                    ),
                  ),
                  Flexible(
                    child: RichText(
                      text: const TextSpan(
                        text: 'You don\'t have a Medherence account? ',
                        style: TextStyle(
                          letterSpacing: 0.3,
                          fontStyle: FontStyle.italic,
                          color: AppColors.darkGrey,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Reach out to your Healthcare Provider to enroll you on the platform',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.3,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
