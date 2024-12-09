import 'package:flutter/material.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/image_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../../more_features/app_version/app_version.dart';
import '../widgets/about_widget.dart';
import 'about_view.dart';
import '../../more_features/privacy_policy/privacy_policy_view.dart';

class AboutScreenView extends StatelessWidget {
  const AboutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the SizeMg class with the context
    SizeMg.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontSize: SizeMg.text(25), // Set the font size using SizeMg
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins-bold.ttf",
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set the height to match the screen height
        width: MediaQuery.of(context)
            .size
            .width, // Set the width to match the screen width
        decoration: const BoxDecoration(
          color: AppColors.white, // Set the background color
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeMg.width(15), // Set left padding using SizeMg
            right: SizeMg.width(15), // Set right padding using SizeMg
            top: SizeMg.height(44), // Set top padding using SizeMg
          ),
          child: Column(
            children: [
              AboutWidget(
                title: 'App Version',
                subtitle: 'Report any difficulty you are facing',
                icon: Icons.arrow_forward_ios_rounded,
                onPressed: () {
                  // Navigate to app version control screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AppVersionView()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImageUtils.appVersionIcon,
                    height: SizeMg.height(24), // Set the height using SizeMg
                    width: SizeMg.width(24), // Set the width using SizeMg
                  ),
                ),
              ),
              SizedBox(
                height: SizeMg.height(15), // Add vertical spacing using SizeMg
              ),
              AboutWidget(
                icon: Icons.arrow_forward_ios_rounded,
                title: 'Privacy Policy',
                subtitle: 'Data collection, usage and protection',
                onPressed: () {
                  // Navigate to privacy policy screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyView()),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      ImageUtils.privacyPolicyIcon,
                      height: SizeMg.height(24), // Set the height using SizeMg
                      width: SizeMg.width(24), // Set the width using SizeMg
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              AboutWidget(
                icon: Icons.arrow_forward_ios_rounded,
                title: 'About Medherence',
                subtitle: 'Learn more about Medherence Ltd.',
                onPressed: () {
                  // Navigate to about app screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutAppView()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    ImageUtils.medherenceAppIcon,
                    height: SizeMg.height(24), // Set the height using SizeMg
                    width: SizeMg.width(24), // Set the width using SizeMg
                  ),
                ),
              ),
              SizedBox(
                height: SizeMg.height(15), // Add vertical spacing using SizeMg
              ),
            ],
          ),
        ),
      ),
    );
  }
}
