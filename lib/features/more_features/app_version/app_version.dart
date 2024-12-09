import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medherence/core/shared_widget/buttons.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';

class AppVersionView extends StatelessWidget {
  const AppVersionView({super.key});

  @override
  Widget build(BuildContext context) {
    String supportMail = 'medherence23@gmail.com';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Version',
          style: TextStyle(
            fontSize: SizeMg.text(25),
            fontWeight: FontWeight.w600,
            // Removed unused fontFamily property
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
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Current App version'),
            _buildAppVersionInfo('App version 1.0.0'),
            const SizedBox(height: 20),
            _buildSectionTitle('Previous App version'),
            _buildAppVersionInfo('---'),
            const SizedBox(height: 20),
            _buildSectionTitle('App Support'),
            _buildSupportInfo(context, supportMail),
            const SizedBox(height: 20),
            _buildSectionTitle('Beta version info'),
            _buildAppVersionInfo('---'),
            const SizedBox(height: 50),
            _buildCheckUpdatesButton(context),
          ],
        ),
      ),
    );
  }

  /// Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.darkGrey,
      ),
    );
  }

  /// Helper method to build app version information
  Widget _buildAppVersionInfo(String version) {
    return Text(
      version,
      style: TextStyle(
        color: AppColors.navBarColor,
        fontSize: 20,
      ),
    );
  }

  /// Helper method to build support information
  Widget _buildSupportInfo(BuildContext context, String supportMail) {
    return ListTile(
      title: Text(
        supportMail,
        style: const TextStyle(
          fontSize: 20,
          color: AppColors.navBarColor,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: supportMail));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Text copied to clipboard'),
            ),
          );
        },
        icon: const Icon(
          Icons.copy,
          color: AppColors.navBarColor,
          size: 25,
        ),
      ),
    );
  }

  /// Helper method to build the 'Check for updates' button
  Widget _buildCheckUpdatesButton(BuildContext context) {
    return OutlinePrimaryButton(
      buttonConfig: ButtonConfig(
        text: 'Check for updates',
        action: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No updates found, you are up to date!'),
            ),
          );
        },
        disabled: true, // Placeholder for future functionality
      ),
      width: SizeMg.width(250),
    );
  }
}
