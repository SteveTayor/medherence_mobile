import 'package:flutter/material.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/size_manager.dart';
import '../../monitor/view_model/reminder_view_model.dart';
import '../view_model/filter_model.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  void initState() {
    super.initState();
    // Fetch regimen list from ReminderState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ReminderState reminderState =
          Provider.of<ReminderState>(context, listen: false);
      List<String> regimenNames = reminderState.regimenList
          .map((regimen) => regimen.regimenName)
          .toList();
      Provider.of<FilterViewModel>(context, listen: false)
          .setRegimenNames(regimenNames);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FilterViewModel>(context);
    String formattedDate = model.formatDate(model.selectedDate);
    String secondFormattedDate = model.formatDate(model.secondSelectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter',
          style: TextStyle(
            fontSize: SizeMg.text(25),
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins-bold.ttf",
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.navBarColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              Icons.check,
              color: AppColors.navBarColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  _buildStatusRadio(model, Status.all, 'All'),
                  _buildStatusRadio(model, Status.taken, 'Taken'),
                  _buildStatusRadio(model, Status.late, 'Late'),
                  _buildStatusRadio(model, Status.missed, 'Missed'),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildDatePicker(
                      context,
                      model,
                      'From',
                      formattedDate,
                      model.selectedDate,
                      (pickedDate) {
                        if (pickedDate != null &&
                            pickedDate != model.selectedDate) {
                          model.updateSelectedDate(pickedDate);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10), // Add some space between the pickers
                  Expanded(
                    child: _buildDatePicker(
                      context,
                      model,
                      'To',
                      secondFormattedDate,
                      model.secondSelectedDate,
                      (pickedDate) {
                        if (pickedDate != null &&
                            pickedDate != model.secondSelectedDate) {
                          model.updateSecondSelectedDate(pickedDate);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              DropDownSearchFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: model.dropDownSearchController,
                  decoration: InputDecoration(
                    hintStyle: kFormTextDecoration.hintStyle,
                    hintText: 'Type in and select the medication',
                    filled: false,
                    fillColor: kFormTextDecoration.fillColor,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    border: kFormTextDecoration.border,
                    focusedBorder: kFormTextDecoration.focusedBorder,
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return model.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  model.dropDownSearchController.text = suggestion;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a medication';
                  }
                  return null;
                },
                onSaved: (value) => model.selectedMedication = value,
                displayAllSuggestionWhenTap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRadio(FilterViewModel model, Status status, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<Status>(
          activeColor: AppColors.navBarColor,
          value: status,
          groupValue: model.status,
          onChanged: (Status? value) {
            if (value != null) {
              model.setStatus(value);
            }
          },
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(
      BuildContext context,
      FilterViewModel model,
      String label,
      String date,
      DateTime initialDate,
      void Function(DateTime?) onDatePicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: AppColors.darkGrey.withOpacity(0.4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGrey,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    onDatePicked(pickedDate);
                  },
                  icon: const Icon(
                    Icons.calendar_today,
                    color: AppColors.navBarColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
