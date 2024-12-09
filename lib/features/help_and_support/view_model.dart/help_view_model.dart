import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpAndSupportModel {
  final String title;
  final String subtitle;

  HelpAndSupportModel({
    required this.title,
    required this.subtitle,
  });

  void copySubtitle(BuildContext context) {
    Clipboard.setData(ClipboardData(text: subtitle));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text copied to clipboard'),
      ),
    );
  }
}
