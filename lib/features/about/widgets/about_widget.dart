import 'package:flutter/material.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';

class AboutWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final Widget child;
  final IconData? icon;

  const AboutWidget({
    super.key,
    required this.icon,
    required this.child,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
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
                  child: child,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: SizeMg.text(18),
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
                  icon: Icon(
                    icon,
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
