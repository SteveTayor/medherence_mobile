import 'package:flutter/material.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/image_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../../help_and_support/view/help_and_support.dart';
import '../../help_and_support/widget/support_widget.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Our app is committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, and disclose your information when you use our app.',
                style: TextStyle(
                  fontSize: SizeMg.text(16),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins-bold.ttf",
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Information We Collect \n',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGrey,
                    fontFamily: "Poppins-bold.ttf",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RichText(
                  text: const TextSpan(
                    text: '- Personal Information: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontFamily: "Poppins-bold.ttf",
                    ),
                    children: [
                      TextSpan(
                        text:
                            'When you register an account, we collect personal information such as your name, email address, and account number.\n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: '- Medication Information: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We collect information about the medications you take, including dosage and frequency, to provide you with medication reminders and track your adherence.\n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: '- Usage Information: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We collect information about how you use the app, such as the features you access and the frequency of use.\n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  text: ' How We Use Your Information \n',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGrey,
                    fontFamily: "Poppins-bold.ttf",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RichText(
                  text: const TextSpan(
                    text: '- To Provide Services: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontFamily: "Poppins-bold.ttf",
                    ),
                    children: [
                      TextSpan(
                        text:
                            'We use your information to provide you with medication reminders, track your adherence, and offer rewards based on your adherence.\n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: '- To Improve Our Services: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We use your information to analyze app usage patterns and improve our services and features.\n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: '- To Communicate With You: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We may use your information to send you important notifications and updates about the app. \n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  text: 'Information Sharing and Disclosure  \n',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGrey,
                    fontFamily: "Poppins-bold.ttf",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RichText(
                  text: const TextSpan(
                    text: '- Third-Party Service Providers: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontFamily: "Poppins-bold.ttf",
                    ),
                    children: [
                      TextSpan(
                        text:
                            'We may share your information with third-party service providers who help us provide and improve our services. \n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: '- Legal Requirements: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'We may disclose your information if required to do so by law or in response to a court order.\n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  text: 'Data Security \n',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    fontFamily: "Poppins-bold.ttf",
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We take reasonable measures to protect your information from unauthorized access, disclosure, alteration, or destruction.\n',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  text: 'Changes to This Privacy Policy \n',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    fontFamily: "Poppins-bold.ttf",
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We reserve the right to update or change this Privacy Policy at any time. We will notify you of any changes by posting the new Privacy Policy on this page. \n',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontFamily: "Poppins-bold.ttf",
                ),
              ),
              const SizedBox(height: 15),
              HelpAndSupportWidget(
                model: HelpAndSupport().customerCareModel,
                icon: Icons.copy,
                copyButton: true,
                onPressed: () {
                  HelpAndSupport().customerCareModel.copySubtitle(context);
                  // Navigate to settings screen
                  // ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImageUtils.callIcon,
                    height: SizeMg.height(24),
                    width: SizeMg.width(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              HelpAndSupportWidget(
                icon: Icons.copy,
                model: HelpAndSupport().emailModel,
                copyButton: true,
                onPressed: () {
                  HelpAndSupport().emailModel.copySubtitle(context);
                  // Navigate to settings screen
                  // ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    ImageUtils.emailMessageIcon,
                    height: SizeMg.height(24),
                    width: SizeMg.width(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
