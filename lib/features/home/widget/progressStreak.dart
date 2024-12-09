import 'package:flutter/material.dart';
import 'package:medherence/core/utils/color_utils.dart';
import 'package:medherence/core/utils/image_utils.dart';
import 'package:medherence/core/utils/size_manager.dart';


class ProgressStreak extends StatelessWidget {
  final int progress;

  const ProgressStreak({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Stack(
      children: [
        SizedBox(
          width: SizeMg.screenWidth,
          child: Stack(
            children: [
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.progressBarFill,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: (progress / 30) * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.navBarColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 10.0,
              //     right: 10,
              //     top: 4,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: List.generate(
              //       10,
              //       (index) {
              //         return Text(
              //           '${index + 1}',
              //           style: TextStyle(
              //             color: index < progress
              //                 ? AppColors.navBarColor
              //                 : Colors.grey,
              //             fontWeight: FontWeight.w200,
              //             fontSize: 8,
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Image.asset(
            ImageUtils.avatar16,
            // width: 3,
            height: 23,
          ),
        ),
      ],
    );
  }
}
