import 'package:flutter/material.dart';

import '../model/models/faqs_model.dart';

class FAQProvider with ChangeNotifier {
  final List<FAQModel> _faqs = [
    {
      "question": "How does the app track my medication adherence?",
      "answer":
          "The app uses AI technology to track your medication intake. It scans and analyzes certain points while taking your medication."
    },
    {
      "question": "How do I earn coins for using my medication?",
      "answer":
          "You earn coins each time you successfully confirm taking your medication as directed by the app. The more consistently you adhere to your medication schedule, the more coins you can earn."
    },
    {
      "question": "What can I do with the coins I earn?",
      "answer":
          "You can withdraw the coins in your local currency after you complete one adherence bar. You get one withdrawal chance after completing an adherence bar."
    },
    {
      "question": "Can I track multiple medications with the app?",
      "answer":
          "Yes, you can track multiple medications simultaneously. All medications inputted or uploaded by your Health Care Provider (HCP) appears on your medication list in monitor."
    },
    {
      "question": "What happens if I forget to take my medication?",
      "answer":
          "If you forget to take your medication, fret not. You can take it later still with the Intelligent Medication Adherence Monitor (IMAM) to increase the adherence bar but with no coin earning."
    },
    {
      "question": "Is my medication adherence data secure?",
      "answer":
          "Yes, your medication adherence data is securely stored and protected. The app complies with all relevant privacy regulations to ensure your information remains confidential."
    },
    {
      "question": "Is my picture/video of taking my medications safe?",
      "answer":
          "Yes, the app does not store or transmit your video/picture. It scans and analyzes the pill, capsule etc to ensure that you used the medication appropriately."
    },
    {
      "question": "Can I customize my medication schedule?",
      "answer":
          "No you cannot. Your medication schedule is inputted by your Healthcare Provider (HCP). You can only customize the alarm settings."
    },
    {
      "question": "Is the app compatible with all types of medications?",
      "answer":
          "The app is designed to track a wide range of medications. However, if you encounter any issues, you can contact customer support for assistance."
    },
    {
      "question": "Can I use the app to track medication for someone else?",
      "answer":
          "No, you cannot. When logged into your account, you can only track your medication as the regimens match your prescription. Someone else can only use your app if they log into their account on your device."
    },
    {
      "question":
          "How can I get support if I have questions or need help with the app?",
      "answer":
          "If you have any questions or need assistance, you can contact our customer support team through phone calls or mails. We're here to help!"
    }
  ].map((json) => FAQModel.fromJson(json)).toList();

  List<FAQModel> get faqs => _faqs;
}
