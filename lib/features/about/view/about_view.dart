import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../view_model/about_view_model.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    const String url = 'https://www.medherence.health'; 
    return ViewModelBuilder<AboutViewModel>.reactive(
      viewModelBuilder: () => AboutViewModel(),
      builder: (_, model, __) =>Scaffold(
          appBar: AppBar(
            title: Text(
              'About Medherence',
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                25.0,
                15,
                25,
                25,
              ),
              child: Column(
                children: [
                  Text(
                    'Medherence mobile application is an Artificial Intelligence enabled healthcare solution designed to improve medication adherence and patient outcomes in people with chronic diseases. Our app is a revolutionary medication adherence platform seamlessly integrated with hospitals, allowing healthcare providers to input patient details and prescribed medications directly.\n\nPatients are incentivized to adhere to their medication schedules through a unique rewards system where they earn coins for each successful daily adherence. These coins can be redeemed for a variety of rewards, promoting better health outcomes and encouraging medication compliance. \n\nAdditionally, patients are monitored using an artificial intelligence model that scans them while they take their medications, ensuring that they\'ve successfully taken their medications. With our app, managing your medications has never been more rewarding and effortless.',
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins-bold.ttf",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Visit; ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: url,
                          recognizer: TapGestureRecognizer()
                              ..onTap = () => model.launchInBrowserView(Uri.parse(url), context),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.navBarColor,
                          ),
                        ),
                        const TextSpan(
                          text: ' to learn more about the app and the company',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),);
      }
  }

