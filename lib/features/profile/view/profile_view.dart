import 'package:flutter/material.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:medherence/core/shared_widget/buttons.dart';
import 'package:medherence/features/auth/widget/validation_extension.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/size_manager.dart';
import '../../auth/widget/textfield.dart';
import '../view_model/profile_view_model.dart';
import '../widget/avatar_overlay_widget.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: AppColors.progressBarFill,
                    radius: 60,
                    child: Image.asset(
                      context.watch<ProfileViewModel>().selectedAvatar,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: AvatarSelectionOverlay(
                              onAvatarSelected: (avatar) {
                                Provider.of<ProfileViewModel>(context,
                                        listen: false)
                                    .setAvatar(avatar);
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Customize your avatar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.navBarColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Consumer<ProfileViewModel>(
              builder: (context, model, _) {
                return _buildForm(model);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 200.0,
      ),
      child: ListView(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 20,
        ),
        children: [
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleAndTextFormField(
                  title: 'Nickname(Optional)',
                  formFieldHint: 'Type your nickname',
                  formFieldController: model.nicknameController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  formFieldColor: model.nicknameFillColor,
                  formFieldValidator: (value) {
                    return value.nameValidation();
                  },
                  onChanged: (value) {
                    setState(() {
                      // Check if the value is not empty
                      if (value.isNotEmpty) {
                        // If there is input, set filled to true
                        model.nicknameFillColor =
                            kFormTextDecoration.fillColor!;
                      } else {
                        // If no input, set filled to false
                        model.nicknameFillColor = Colors.white70;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'First Name',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: 'Demoj',
                  enabled: false,
                  readOnly: true,
                  decoration: kFormTextDecoration.copyWith(
                    hintText: "",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Last Name',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: 'Adekunle',
                  enabled: false,
                  readOnly: true,
                  decoration: kFormTextDecoration.copyWith(
                    hintText: "",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: '09123456789',
                  enabled: false,
                  readOnly: true,
                  decoration: kFormTextDecoration.copyWith(
                    hintText: "",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Age',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: '30',
                  enabled: false,
                  readOnly: true,
                  decoration: kFormTextDecoration.copyWith(
                    hintText: "",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: model.gender,
                            onChanged: model.setGender,
                          ),
                          const Text('Male', style: TextStyle(fontSize: 16))
                        ],
                      ),
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: model.gender,
                            onChanged: model.setGender,
                          ),
                          const Text('Female', style: TextStyle(fontSize: 16))
                        ],
                      ),
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: model.gender,
                            onChanged: model.setGender,
                          ),
                          const Text('Others', style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Next of Kin information',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkGrey,
                  ),
                ),
                SizedBox(height: SizeMg.height(15)),
                TitleAndTextFormField(
                  title: 'First Name',
                  formFieldHint: 'Type your NOK\'s first name',
                  formFieldController: model.nokFirstNameController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  formFieldColor: model.nokFirstFillColor,
                  formFieldValidator: (value) {
                    return value.nameValidation();
                  },
                  onChanged: (value) {
                    setState(() {
                      // Check if the value is not empty
                      if (value.isNotEmpty) {
                        // If there is input, set filled to true
                        model.nokFirstFillColor = kFormTextDecoration.fillColor;
                      } else {
                        // If no input, set filled to false
                        model.nokFirstFillColor = Colors.white70;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                TitleAndTextFormField(
                  title: 'Last Name',
                  formFieldHint: 'Type your NOK\'s last name',
                  formFieldController: model.nokLastNameController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  formFieldColor: model.nokLastFillColor,
                  formFieldValidator: (value) {
                    return value.nameValidation();
                  },
                  onChanged: (value) {
                    setState(() {
                      // Check if the value is not empty
                      if (value.isNotEmpty) {
                        // If there is input, set filled to true
                        model.nokLastFillColor = kFormTextDecoration.fillColor;
                      } else {
                        // If no input, set filled to false
                        model.nokLastFillColor = Colors.white70;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                TitleAndTextFormField(
                  title: 'Phone Number',
                  formFieldHint: 'Type your NOK\'s number',
                  formFieldController: model.nokPhoneNumberController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  formFieldColor: model.nokPhoneFillColor,
                  formFieldValidator: (value) {
                    return value.phoneNumberValidation();
                  },
                  onChanged: (value) {
                    setState(() {
                      // Check if the value is not empty
                      if (value.isNotEmpty) {
                        // If there is input, set filled to true
                        model.nokPhoneFillColor = kFormTextDecoration.fillColor;
                      } else {
                        // If no input, set filled to false
                        model.nokPhoneFillColor = Colors.white70;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                TitleAndTextFormField(
                  title: 'Relationship',
                  formFieldHint: 'e.g Mother',
                  formFieldController: model.nokRelationController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  formFieldColor: model.nokRelationFillColor,
                  formFieldValidator: (value) {
                    return value.nameValidation();
                  },
                  onChanged: (value) {
                    setState(() {
                      // Check if the value is not empty
                      if (value.isNotEmpty) {
                        // If there is input, set filled to true
                        model.nokRelationFillColor =
                            kFormTextDecoration.fillColor;
                      } else {
                        // If no input, set filled to false
                        model.nokRelationFillColor = Colors.white70;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 50),
          PrimaryButton(
            textSize: SizeMg.text(25),
            buttonConfig: ButtonConfig(
              action: () {
                Provider.of<ProfileViewModel>(context, listen: false)
                    .setNickName(model.nicknameController.text.trim());
                model.saveProfile(context);
                Navigator.pop(context);
              },
              text: 'Save Changes',
              disabled: false,
              // !model.isFormValid,
            ),
            width: double.infinity,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
