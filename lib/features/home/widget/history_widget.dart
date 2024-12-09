// import 'package:flutter/material.dart';

// import '../../../core/constants_utils/color_utils.dart';

// class HistoryWidget extends StatelessWidget {
//   const HistoryWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> historyLists = [];
//     return _buildHistoryScreen(historyLists, context);
//   }

//    _buildHistoryScreen(List<dynamic> historyList, BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return ClipRRect(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(
//               (50),
//             ),
//             topLeft: Radius.circular(
//              (50),
//             ),
//           ),
//           child: ColoredBox(
//             color: AppColors.historyBackground,
//             child: DraggableScrollableSheet(
//               initialChildSize: 0.4,
//               maxChildSize: 0.8,
//               expand: true,
//               builder: (context, scrollController) {
//                 if (historyList == null || historyList.isEmpty) {
//                   return Center(
//                     child: Container(
//                       height: 150,
//                       width: 280,
//                       child: Column(
//                         children: [
//                           Icon(Icons.folder_off_outlined, color: AppColors.noWidgetText,),
//                           SizedBox(height: 10,),
//                           Text(
//                             'You have no adherence history',
//                             style: TextStyle(
//                               fontSize: (15),
//                               color: AppColors.noWidgetText,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//                 return SingleChildScrollView(
//                   controller: scrollController,
//                   child: Column(
//                     children: [
//                       Container(
//                         height: (10),
//                         margin: EdgeInsets.symmetric(
//                           horizontal:(140),
//                           vertical: (30),
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.darkGrey,
//                           borderRadius: BorderRadius.circular(
//                             (30),
//                           ),
//                         ),
//                       ),
//                       ListView.separated(
//                         shrinkWrap: true,
//                         physics: const BouncingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           final historyModel = historyList[index];
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: (26),
//                                   right: (26),
//                                   bottom: (28),
//                                 ),
                                
//                               ),
//                             ],
//                           );
//                         },
//                         separatorBuilder: (ctx, index) {
//                           return SizedBox(
//                             height: (33),
//                           );
//                         },
//                         itemCount: historyList.length,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }