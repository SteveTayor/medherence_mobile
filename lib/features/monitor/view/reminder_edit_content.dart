// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/utils/color_utils.dart';
// import '../view_model/reminder_view_model.dart';

// class EditReminderScreenContent extends StatefulWidget {
//   const EditReminderScreenContent({super.key});

//   @override
//   State<EditReminderScreenContent> createState() =>
//       _EditReminderScreenContentState();
// }

// class _EditReminderScreenContentState extends State<EditReminderScreenContent> {
//   bool isDoneClicked = false;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ReminderState>(
//       create: (_) => ReminderState(),
//       child: Consumer<ReminderState>(builder: (context, reminderState, _) {
//         return Container(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                   bottom: 25,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Regimen description',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.inactiveGrey,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     buildDetailItem(
//                         'Name', reminderState.regimenList.last.regimenName),
//                     buildDetailItem(
//                         'Medication form',
//                         reminderState.regimenList.last.regimenDescription
//                             .medicationForm),
//                     buildDetailItem(
//                         'Dosage', reminderState.regimenList.last.dosage),
//                     buildDetailItem(
//                         'Pill Time',
//                         reminderState
//                             .regimenList.last.regimenDescription.pillTime),
//                     buildDetailItem(
//                         'Pill Frequency',
//                         reminderState
//                             .regimenList.last.regimenDescription.pillFrequency),
//                     buildDetailItem(
//                         'Duration',
//                         reminderState
//                             .regimenList.last.regimenDescription.duration),
//                     buildDetailItem(
//                         'Notes',
//                         reminderState
//                             .regimenList.last.regimenDescription.notes),
//                   ],
//                 ),
//               ),
//               const Divider(color: AppColors.inactiveGrey),
//               Padding(
//                 padding: const EdgeInsets.all(
//                   25,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Alarm settings',
//                       style: TextStyle(
//                         color: AppColors.darkGrey,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Sound',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('Select Sound'),
//                                   content: Padding(
//                                     padding:
//                                         const EdgeInsets.only(bottom: 38.0),
//                                     child: DropdownButton<String>(
//                                       value: reminderState.selectedSound,
//                                       onChanged: (String? newValue) {
//                                         setState(() {
//                                           reminderState
//                                               .updateSelectedSound(newValue!);
//                                           Navigator.of(context)
//                                               .pop(); // Close the dialog after selecting a sound
//                                         });
//                                       },
//                                       items: <String>[
//                                         'Aegean Sea',
//                                         'Bird Chirping',
//                                         'Wind Blowing'
//                                       ].map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Row(
//                             children: [
//                               Text(
//                                 reminderState.selectedSound,
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ),
//                               SizedBox(width: 2),
//                               Icon(
//                                 Icons.arrow_forward_ios_rounded,
//                                 size: 16,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Set Alarm',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             final TimeOfDay? pickedTime = await showTimePicker(
//                               context: context,
//                               initialTime: reminderState.selectedTime,
//                             );
//                             if (pickedTime != null &&
//                                 pickedTime != reminderState.selectedTime)
//                               reminderState.updateSelectedTime(pickedTime);
//                           },
//                           child: Text(
//                             reminderState.selectedTime.format(context),
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Snooze',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         Switch.adaptive(
//                           activeTrackColor: Colors.green,
//                           value: reminderState.val,
//                           onChanged: (bool value) {
//                             setState(() {
//                               reminderState.updateVal(value);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(color: AppColors.inactiveGrey),
//               Padding(
//                 padding: const EdgeInsets.all(
//                   25,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Pill Count',
//                           style: TextStyle(
//                             color: AppColors.darkGrey,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Switch.adaptive(
//                           activeTrackColor: Colors.green,
//                           value: reminderState.pillCount,
//                           onChanged: (bool value) {
//                             setState(() {
//                               reminderState.updatePillCount(value);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     IgnorePointer(
//                       ignoring: !reminderState.pillCount,
//                       child: Opacity(
//                         opacity: reminderState.pillCount ? 1.0 : 0.5,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             buildPillCountItem('Number of Pills', '0 pills'),
//                             buildPillCountItem(
//                                 'Start remainder at', '0 pills remaining'),
//                             buildPillCountItem('Time', '00:00 pm'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget buildDetailItem(String title, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: AppColors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Container(
//           height: 40,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: AppColors.progressBarFill,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: AppColors.regmentColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   Widget buildPillCountItem(String title, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Container(
//           height: 35,
//           decoration: BoxDecoration(
//             border: Border.all(width: 1),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               textAlign: TextAlign.center,
//               value,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
