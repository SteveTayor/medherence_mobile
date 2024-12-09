// import 'package:flutter/material.dart';

// import '../../../core/utils/color_utils.dart';
// import '../../../core/utils/size_manager.dart';

// class MedcoinWidget extends StatelessWidget {
//   bool amountChanged;
//   VoidCallback onTap;

//   MedcoinWidget(
//     this.onTap,
//     this.amountChanged, {
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     SizeMg.init(context);
//     String coinTitle = 'Amount in Naira';
//     String amount = '500';
//     if (amountChanged == true) {
//       coinTitle = 'Amount in MDHC';
//       amount = '1000.00 ';
//     }
//     return Stack(
//       children: [
//         Container(
//           height: SizeMg.height(120),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: AppColors.medMidgradient,
//           ),
//         ),
//         Container(
//           // Set the width of the container
//           height: SizeMg.height(120), // Set the height of the container
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               begin: Alignment.centerLeft, // Start the gradient from the left
//               end: Alignment.centerRight, // End the gradient to the right
//               colors: [
//                 AppColors.mainPrimaryButton.withOpacity(0.6),
//                 AppColors.disabledButton.withOpacity(0.6),
//               ], // Define the colors for the gradient
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 left: 20.0, right: 20.0, top: 20, bottom: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Medhecoin Balance',
//                       style: TextStyle(
//                         color: AppColors.white,
//                         fontSize: SizeMg.text(14),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//                 amountChanged == true
//                     ? RichText(
//                         text: TextSpan(
//                           text: '\u{20A6}',
//                           style: TextStyle(
//                             fontSize: SizeMg.text(25),
//                             color: Colors.white,
//                             letterSpacing: 1.5,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: amount,
//                             ),
//                           ],
//                         ),
//                       )
//                     : Text(
//                         amount,
//                         style: TextStyle(
//                           fontSize: SizeMg.text(25),
//                           color: Colors.white,
//                           letterSpacing: 1.5,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: onTap,
//                         child: Text(
//                           coinTitle,
//                           style: TextStyle(
//                             color: AppColors.offWhite,
//                             fontSize: SizeMg.text(14),
//                             fontWeight: FontWeight.w400,
//                             decorationColor: AppColors.white,
//                             decoration: TextDecoration
//                                 .underline, // Add underline decoration
//                           ),
//                         ),
//                       ),
//                       // Spacer(),
//                       Image.asset(
//                         'assets/images/coin.png',
//                         height: SizeMg.height(30),
//                         width: SizeMg.width(28),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
