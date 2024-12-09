import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medherence/core/shared_widget/buttons.dart';
import 'package:medherence/core/utils/date_utils.dart';
import 'package:provider/provider.dart';

import '../../../core/model/models/history_model.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../view_model/reminder_view_model.dart';
import '../widget/medcoin_drop_widget.dart';

class EditReminderDetails extends StatefulWidget {
  const EditReminderDetails({super.key});

  @override
  _EditReminderDetailsState createState() => _EditReminderDetailsState();
}

class _EditReminderDetailsState extends State<EditReminderDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderState>(
      builder: (context, reminderState, _) {
        List<HistoryModel> regimenList = reminderState.regimenList;
        int checkedCount = reminderState.getCheckedCount();
        bool showButton = checkedCount > 0;
        bool allSelected = reminderState.areAllSelected();

        return SizedBox(
          width: SizeMg.screenWidth,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Show message when regimenList is empty
              if (regimenList.isEmpty) _buildEmptyListMessage(),
              // List of regimen items
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemCount: regimenList.length,
                  itemBuilder: (context, index) {
                    HistoryModel regimen = regimenList[index];
                    return _buildRegimenTile(context, regimen, reminderState);
                  },
                ),
              ),
              // Option to select all if not all items are selected
              if (regimenList.isNotEmpty && !allSelected)
                _buildSelectAllOption(),
              // Action button section when items are selected
              if (showButton)
                _buildActionButton(context, checkedCount, regimenList),
            ],
          ),
        );
      },
    );
  }

  /// Widget for displaying a message when regimenList is empty
  Widget _buildEmptyListMessage() {
    return Center(
      child: SizedBox(
        height: 250,
        width: 300,
        child: Column(
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.check_circle_outline_sharp,
              color: AppColors.noWidgetText,
              size: 30,
            ),
            SizedBox(height: 10),
            Text(
              'Yayy, You have taken all medications for today',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: AppColors.noWidgetText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Widget for building each regimen tile in the list
  Widget _buildRegimenTile(
    BuildContext context,
    HistoryModel regimen,
    ReminderState state,
  ) {
    bool isChecked = state.isChecked(regimen);
    return Container(
      width: SizeMg.screenWidth,
      decoration: BoxDecoration(
        color:
            isChecked ? AppColors.historyBackground : AppColors.unToggledColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Checkbox for selecting regimen item
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 8),
            child: Checkbox(
              activeColor: isChecked ? AppColors.navBarColor : AppColors.white,
              fillColor: isChecked
                  ? MaterialStateProperty.all<Color>(AppColors.navBarColor)
                  : MaterialStateProperty.all<Color>(AppColors.white),
              side: const BorderSide(
                color: AppColors.navBarColor,
                width: 2.5,
              ),
              value: state.isChecked(regimen),
              onChanged: (value) {
                state.toggleChecked(regimen);
              },
            ),
          ),
          // Pill icon for regimen
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Image.asset(
              'assets/images/pill.png',
              height: 28,
              width: 28,
            ),
          ),
          // Regimen details: name and dosage
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                regimen.regimenName,
                style: TextStyle(
                  fontSize: SizeMg.text(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                regimen.dosage,
                style: TextStyle(
                  fontSize: SizeMg.text(12),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Time of regimen
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20.0,
              right: 10,
            ),
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                  top: 8,
                  bottom: 0,
                ),
                child: Text(
                  DateFormat('hh:mm a').format(DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    regimen.time.hour,
                    regimen.time.minute,
                  )),
                  style: TextStyle(
                    color: AppColors.navBarColor,
                    fontSize: SizeMg.text(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget for displaying 'Select All' option when not all items are selected
  Widget _buildSelectAllOption() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        children: [
          Spacer(),
          InkWell(
            onTap: () {
              Provider.of<ReminderState>(context, listen: false).selectAll();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text(
                'Select All',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: AppColors.pillIconColor,
                  fontSize: SizeMg.text(14),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget for displaying action button when items are selected
  Widget _buildActionButton(
    BuildContext context,
    int checkedCount,
    List<HistoryModel> regimenList,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeMg.width(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            // Informational text for selected items
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: SizeMg.width(8)),
                  child: Icon(
                    Icons.feedback_rounded,
                    color: Colors.blue.shade200,
                  ),
                ),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text:
                          'Select multiple medications if you\'ll be using them together, and select them singly if you\'ll be using them separately.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: SizeMg.text(12),
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Button for taking medications
            PrimaryButton(
              height: SizeMg.height(45),
              textSize: SizeMg.text(23),
              buttonConfig: ButtonConfig(
                text: 'Take med',
                extraText: ' ($checkedCount)',
                action: () {
                  // Calculate Medhecoin earned and update state
                  int medhecoinEarned = checkedCount * 100;
                  Provider.of<ReminderState>(context, listen: false)
                      .addMedcoin(medhecoinEarned);

                  // Show feedback and update history for taken items
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pills taken successfully')),
                  );

                  // Get current date and time
                  DateTime now = DateTime.now();

                  // Update history and regimen list
                  List<HistoryModel> updatedList = regimenList.where((regimen) {
                    if (Provider.of<ReminderState>(context, listen: false)
                        .isChecked(regimen)) {
                      DateTime regimenTime = DateTime(
                        regimen.date.year,
                        regimen.date.month,
                        regimen.date.day,
                        regimen.time.hour,
                        regimen.time.minute,
                      );
                      AdherenceStatus status;
                      if (now.isBefore(regimenTime) ||
                          now.isAtSameMomentAs(regimenTime)) {
                        status = AdherenceStatus.early;
                      } else if (now.isAfter(regimenTime) &&
                          regimenTime.isSameDayAs(now)) {
                        status = AdherenceStatus.late;
                      } else {
                        status = AdherenceStatus.missed;
                      }

                      regimen.status = status;

                      // Add to history
                      Provider.of<ReminderState>(context, listen: false)
                          .addHistory(
                        HistoryModel(
                          icon: regimen.icon,
                          regimenName: regimen.regimenName,
                          dosage: regimen.dosage,
                          date: regimen.date,
                          regimenDescription: regimen.regimenDescription,
                          id: regimen.id,
                          time: regimen.time,
                          message: regimen.message,
                          status: regimen.status,
                        ),
                      );
                      return false;
                    }
                    return true;
                  }).toList();
                  // Update regimen list
                  Provider.of<ReminderState>(context, listen: false)
                      .updateRegimenList(updatedList);
                  // Clear checked items
                  Provider.of<ReminderState>(context, listen: false)
                      .clearCheckedItems();
                  // Show MedCoin drop widget
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MedCoinDropWidget(
                        medhecoinEarned: medhecoinEarned,
                      );
                    },
                  );
                },
              ),
              width: SizeMg.screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
