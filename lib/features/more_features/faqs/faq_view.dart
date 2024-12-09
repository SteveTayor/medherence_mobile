import 'package:flutter/material.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/faq_provider.dart';
import 'widget/faq_widget.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    final faqProvider = Provider.of<FAQProvider>(context);
    final faqs = faqProvider.faqs;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
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
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Column(
            children: [
              FAQItem(faq: faq),
              Divider(
                color: AppColors.darkGrey.withOpacity(0.3),
              ),
            ],
          );
        },
      ),
    );
  }
}
