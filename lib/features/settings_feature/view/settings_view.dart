import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/image_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../../monitor/view_model/reminder_view_model.dart';
import '../../more_features/Biometric/biometric_auth.dart';
import '../../more_features/wallet/view/wallet_pin_view.dart';
import '../widget/settings_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isDarkModeEnabled = false;
  void _applyTheme(bool isDarkModeEnabled) {
    if (isDarkModeEnabled) {
      // Apply dark mode theme
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor:
            Colors.black, // Example: Set status bar color for dark mode
      ));
      ThemeData.dark();
    } else {
      // Apply light mode theme
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor:
            Colors.white, // Example: Set status bar color for light mode
      ));
      ThemeData.light();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ReminderState reminderState = ReminderState();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25.0,
            right: 25,
            top: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'General',
              //   style: TextStyle(
              //     color: AppColors.darkGrey,
              //     fontSize: 16,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     child: ListTile(
              //       leading: const Icon(
              //         Icons.dark_mode,
              //         color: AppColors.historyBackground,
              //         size: 25,
              //       ),
              //       title: Text(
              //         'Dark mode',
              //         style: TextStyle(
              //           fontSize: SizeMg.text(20),
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       trailing: Switch.adaptive(
              //         value: isDarkModeEnabled, // Use the boolean variable
              //         onChanged: (value) {
              //           setState(() {
              //             isDarkModeEnabled = value; // Update the state
              //           });
              //           // You can add logic here to apply dark mode
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: SizeMg.height(10)),
              // const Text(
              //   'Alarm settings',
              //   style: TextStyle(
              //     color: AppColors.darkGrey,
              //     fontSize: 16,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 15,
              //     bottom: 15,
              //     left: 10,
              //     right: 10,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text(
              //         'Sound',
              //         style: TextStyle(
              //           fontSize: 22,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       InkWell(
              //         onTap: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return CupertinoAlertDialog(
              //                 title: const Text('Select Sound'),
              //                 content: Padding(
              //                   padding: const EdgeInsets.only(bottom: 38.0),
              //                   child: Consumer<ReminderState>(
              //                     builder: (context, reminderState, _) {
              //                       return DropdownButton<String>(
              //                         value: reminderState.selectedSound,
              //                         onChanged: (String? newValue) {
              //                           setState(() {
              //                             reminderState
              //                                 .updateSelectedSound(newValue!);
              //                             Navigator.of(context)
              //                                 .pop(); // Close the dialog after selecting a sound
              //                           });
              //                         },
              //                         items: <String>[
              //                           'Aegean Sea',
              //                           'Bird Chirping',
              //                           'Wind Blowing',
              //                           'Water Splash'
              //                         ].map<DropdownMenuItem<String>>(
              //                           (String value) {
              //                             return DropdownMenuItem<String>(
              //                               value: value,
              //                               child: Text(value),
              //                             );
              //                           },
              //                         ).toList(),
              //                       );
              //                     },
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         },
              //         child: Row(
              //           children: [
              //             Text(
              //               ReminderState().selectedSound,
              //               style: const TextStyle(
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w300,
              //               ),
              //             ),
              //             const SizedBox(width: 2),
              //             const Icon(
              //               Icons.arrow_forward_ios_rounded,
              //               size: 16,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const Text(
                'Medhecoin Wallet settings',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SettingsWidgetList(
                      title: 'Change wallet Pin',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalletPinView()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          ImageUtils.lockIcon,
                          height: SizeMg.height(24),
                          width: SizeMg.width(24),
                        ),
                      ),
                    ),
                    SettingsWidgetList(
                      title: 'Biometric authentication',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BiometricAuthenticationView()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          ImageUtils.biometricIcon,
                          height: SizeMg.height(24),
                          width: SizeMg.width(24),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
