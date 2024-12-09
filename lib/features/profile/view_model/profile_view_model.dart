import 'package:flutter/material.dart';

import '../../../core/utils/image_utils.dart';

class ProfileViewModel extends ChangeNotifier {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController nokFirstNameController = TextEditingController();
  TextEditingController nokLastNameController = TextEditingController();
  TextEditingController nokPhoneNumberController = TextEditingController();
  TextEditingController nokRelationController = TextEditingController();
  Color? nicknameFillColor = Colors.white70;
  Color? nokFirstFillColor = Colors.white70;
  Color? nokLastFillColor = Colors.white70;
  Color? nokPhoneFillColor = Colors.white70;
  Color? nokRelationFillColor = Colors.white70;
  int gender = 1; // Default to Male
  bool isFormValid = false;
  String selectedAvatar = '';
  String nickName = '';

  ProfileViewModel() {
    nicknameController = TextEditingController();
    nokFirstNameController = TextEditingController();
    nokLastNameController = TextEditingController();
    nokPhoneNumberController = TextEditingController();
    nokRelationController = TextEditingController();
    selectedAvatar = ImageUtils.avatar4; // Default avatar
    nickName = 'ADB';
  }

  void setAvatar(String avatar) {
    selectedAvatar = avatar;
    notifyListeners();
  }

  void setNickName(String name) {
    nickName = name;
    notifyListeners();
  }

  void setGender(int? value) {
    if (value != null) {
      gender = value;
      notifyListeners();
      _validateForm();
    }
  }

  void _validateForm() {
    if (gender != 0 &&
        nokFirstNameController.text.isNotEmpty &&
        nokLastNameController.text.isNotEmpty &&
        nokPhoneNumberController.text.isNotEmpty &&
        nokRelationController.text.isNotEmpty) {
      isFormValid = true;
    } else {
      isFormValid = false;
    }
    notifyListeners();
  }

  void saveProfile(BuildContext context) {
    // Perform form validation
    if (isFormValid) {
      // Show successful toast message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );

      // Redirect to DashboardView
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => DashboardView()),
      // );
    }
  }
}
