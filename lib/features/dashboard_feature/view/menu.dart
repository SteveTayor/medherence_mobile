import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../../../core/shared_widget/buttons.dart';
import '../../about/view/about_screen.dart';
import '../../auth/views/login_view.dart';
import '../../help_and_support/view/help_and_support.dart';
import '../../history/view/history_screen.dart';
import '../../profile/view/profile_view.dart';
import '../../settings_feature/view/settings_view.dart';

/// MenuScreen Widget represents the main menu of the application.
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  /// Signs out the current user by setting 'isSignedIn' to false in SharedPreferences.
  Future<void> signingOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);
  }

  /// Builds a dialog to confirm logout and performs logout action.
  Future<void> buildLogOutDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Logout',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    buttonConfig: ButtonConfig(
                      text: 'LogOut',
                      action: () async {
                        await signingOut();
                        // Navigate back to the login screen and remove all previous routes
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      disabled: false,
                    ),
                    width: 130,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinePrimaryButton(
                    buttonConfig: ButtonConfig(
                      text: 'Cancel',
                      action: () {
                        Navigator.pop(context);
                      },
                      disabled: false,
                    ),
                    width: 130,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const snackbar = SnackBar(
      dismissDirection: DismissDirection.horizontal,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(150),
      content: Text(
        'Coming Soon',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.offWhite,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: AppColors.navBarColor,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins-bold.ttf",
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeMg.height(5),
              left: 15.0,
              right: 15,
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                MenuItemCard(
                  icon: Icons.person_rounded,
                  title: 'Profile',
                  subtitle: 'Complete and edit your profile',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreenView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                MenuItemCard(
                  icon: Icons.history,
                  title: 'History',
                  subtitle: 'Your history',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                MenuItemCard(
                  icon: CupertinoIcons.gear_alt_fill,
                  title: 'Settings',
                  subtitle: 'Personalize and setup your experience',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                MenuItemCard(
                  icon: CupertinoIcons.chat_bubble_2_fill,
                  title: 'Help and Support',
                  subtitle: 'Report any difficulty you are facing',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpAndSupport(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                MenuItemCard(
                  icon: Icons.feedback_rounded,
                  title: 'About app',
                  subtitle: 'Learn more about the app',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreenView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                MenuItemCard(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  subtitle: 'Logout of your account',
                  onPressed: () => buildLogOutDialog(),
                ),
                SizedBox(height: SizeMg.height(100)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Want to rate us? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeMg.text(16),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins-bold.ttf",
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_rate,
                              color: AppColors.navBarColor, size: 30),
                          SizedBox(width: 10),
                          Icon(Icons.star_rate,
                              color: AppColors.navBarColor, size: 30),
                          SizedBox(width: 10),
                          Icon(Icons.star_rate,
                              color: AppColors.navBarColor, size: 30),
                          SizedBox(width: 10),
                          Icon(Icons.star_half,
                              color: AppColors.navBarColor, size: 30),
                          SizedBox(width: 10),
                          Icon(Icons.star_border,
                              color: AppColors.navBarColor, size: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// MenuItemCard Widget represents a card in the menu with an icon, title, subtitle, and onPressed action.
class MenuItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const MenuItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.shadowColor,
      shadowColor: AppColors.progressBarFill,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(1, 1),
                color: AppColors.shadowColor,
              ),
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 0,
                offset: Offset(4, 5),
                color: Color.fromRGBO(26, 85, 171, 0.06),
              ),
              BoxShadow(
                blurRadius: 9,
                spreadRadius: 0,
                offset: Offset(10, 10),
                color: Color.fromRGBO(26, 85, 171, 0.04),
              ),
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(17, 18),
                color: Color.fromRGBO(26, 85, 171, 0.01),
              ),
              BoxShadow(
                blurRadius: 11,
                spreadRadius: 0,
                offset: Offset(27, 29),
                color: Color.fromRGBO(26, 85, 171, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    icon,
                    size: 22,
                    color: AppColors.pillIconColor,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: SizeMg.text(16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: SizeMg.text(12),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.pillIconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../core/utils/color_utils.dart';
// import '../../../core/utils/size_manager.dart';
// import '../../../core/shared_widget/buttons.dart';
// import '../../about/view/about_screen.dart';
// import '../../auth/views/login_view.dart';
// import '../../help_and_support/view/help_and_support.dart';
// import '../../history/view/history_screen.dart';
// import '../../profile/view/profile_view.dart';
// import '../../settings_feature/view/settings_view.dart';

// /// MenuScreen Widget represents the main menu of the application.
// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key});

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   int selectedStar = 0; // Track the selected star rating (0 means no stars selected)

//   /// Signs out the current user by setting 'isSignedIn' to false in SharedPreferences.
//   Future<void> signingOut() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isSignedIn', false);
//   }

//   /// Builds a dialog to confirm logout and performs logout action.
//   Future<void> buildLogOutDialog() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => SimpleDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         children: [
//           const SizedBox(height: 10),
//           const Padding(
//             padding: EdgeInsets.only(top: 8.0),
//             child: Text(
//               'Logout',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 35.0),
//             child: Text(
//               'Are you sure you want to logout?',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: PrimaryButton(
//                     buttonConfig: ButtonConfig(
//                       text: 'LogOut',
//                       action: () async {
//                         await signingOut();
//                         // Navigate back to the login screen and remove all previous routes
//                         Navigator.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute(
//                             builder: (context) => const LoginView(),
//                           ),
//                           (Route<dynamic> route) => false,
//                         );
//                       },
//                       disabled: false,
//                     ),
//                     width: 130,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: OutlinePrimaryButton(
//                     buttonConfig: ButtonConfig(
//                       text: 'Cancel',
//                       action: () {
//                         Navigator.pop(context);
//                       },
//                       disabled: false,
//                     ),
//                     width: 130,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Updates the selected star rating based on the index.
//   void updateSelectedStar(int index) {
//     setState(() {
//       // If the same star is tapped again, toggle it (half/full)
//       if (selectedStar == index) {
//         selectedStar = (selectedStar == index * 2) ? 0 : index * 2;
//       } else {
//         // Else, select the star and its preceding half
//         selectedStar = index * 2 + 1;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Menu',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.w600,
//             fontFamily: "Poppins-bold.ttf",
//           ),
//           textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           color: AppColors.white,
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(
//               top: SizeMg.height(5),
//               left: 15.0,
//               right: 15,
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 15),
//                 // Star Rating Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(5, (index) {
//                     IconData iconData;
//                     Color color;
//                     // Determine icon and color based on selected rating
//                     if (index * 2 < selectedStar) {
//                       iconData = Icons.star;
//                       color = Colors.yellow;
//                     } else if (index * 2 == selectedStar) {
//                       iconData = Icons.star_half;
//                       color = Colors.yellow;
//                     } else {
//                       iconData = Icons.star_border;
//                       color = Colors.grey;
//                     }
//                     return IconButton(
//                       icon: Icon(iconData, color: color),
//                       onPressed: () => updateSelectedStar(index),
//                     );
//                   }),
//                 ),
//                 const SizedBox(height: 15),
//                 // Menu Items
//                 MenuItemCard(
//                   icon: Icons.person_rounded,
//                   title: 'Profile',
//                   subtitle: 'Complete and edit your profile',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ProfileScreenView(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MenuItemCard(
//                   icon: Icons.history,
//                   title: 'History',
//                   subtitle: 'Your history',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HistoryScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MenuItemCard(
//                   icon: CupertinoIcons.gear_alt_fill,
//                   title: 'Settings',
//                   subtitle: 'Personalize and setup your experience',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SettingsView(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MenuItemCard(
//                   icon: CupertinoIcons.chat_bubble_2_fill,
//                   title: 'Help and Support',
//                   subtitle: 'Report any difficulty you are facing',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HelpAndSupport(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MenuItemCard(
//                   icon: Icons.feedback_rounded,
//                   title: 'About app',
//                   subtitle: 'Learn more about the app',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const AboutScreenView(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MenuItemCard(
//                   icon: Icons.logout_rounded,
//                   title: 'Logout',
//                   subtitle: 'Logout of your account',
//                   onPressed: () => buildLogOutDialog(),
//                 ),
//                 SizedBox(height: SizeMg.height(100)),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Want to rate us? ',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: SizeMg.text(16),
//                           fontWeight: FontWeight.w500,
//                           fontFamily: "Poppins-bold.ttf",
//                         ),
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.star_rate,
//                               color: AppColors.navBarColor, size: 30),
//                           SizedBox(width: 10),
//                           Icon(Icons.star_rate,
//                               color: AppColors.navBarColor, size: 30),
//                           SizedBox(width: 10),
//                           Icon(Icons.star_rate,
//                               color: AppColors.navBarColor, size: 30),
//                           SizedBox(width: 10),
//                           Icon(Icons.star_half,
//                               color: AppColors.navBarColor, size: 30),
//                           SizedBox(width: 10),
//                           Icon(Icons.star_border,
//                               color: AppColors.navBarColor, size: 30),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// MenuItemCard Widget represents a card in the menu with an icon, title, subtitle, and onPressed action.
// class MenuItemCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onPressed;

//   const MenuItemCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       surfaceTintColor: AppColors.shadowColor,
//       shadowColor: AppColors.progressBarFill,
//       child: InkWell(
//         onTap: onPressed,
//         child: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.white,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 3,
//                 spreadRadius: 0,
//                 offset: Offset(1, 1),
//                 color: AppColors.shadowColor,
//               ),
//               BoxShadow(
//                 blurRadius: 6,
//                 spreadRadius: 0,
//                 offset: Offset(4, 5),
//                 color: Color.fromRGBO(26, 85, 171, 0.06),
//               ),
//               BoxShadow(
//                 blurRadius: 9,
//                 spreadRadius: 0,
//                 offset: Offset(10, 10),
//                 color: Color.fromRGBO(26, 85, 171, 0.04),
//               ),
//               BoxShadow(
//                 blurRadius: 10,
//                 spreadRadius: 0,
//                 offset: Offset(17, 18),
//                 color: Color.fromRGBO(26, 85, 171, 0.01),
//               ),
//               BoxShadow(
//                 blurRadius: 11,
//                 spreadRadius: 0,
//                 offset: Offset(27, 29),
//                 color: Color.fromRGBO(26, 85, 171, 0),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Icon(
//                     icon,
//                     size: 22,
//                     color: AppColors.pillIconColor,
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: SizeMg.text(16),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         subtitle,
//                         style: TextStyle(
//                           fontSize: SizeMg.text(12),
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: onPressed,
//                   icon: const Icon(
//                     Icons.arrow_forward_ios,
//                     color: AppColors.pillIconColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
