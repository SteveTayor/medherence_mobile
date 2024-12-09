import 'package:flutter/material.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/model/models/regimen_model.dart';
import '../../../core/model/simulated_data/simulated_values.dart';

class MedicationDetailsScreen extends StatelessWidget {
  String title;
  MedicationDetailsScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final List<RegimenDescriptionModel> regimenDescription =
        generateSimulatedRegimenDescriptions();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                '20mg',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 50),
              const CircleAvatar(
                radius: 85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tablets left',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '10 Tablets',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.mainPrimaryButton,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Capsule used',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.navBarColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Capsule missed',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    color: AppColors.historyBackground,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: regimenDescription.length,
                      itemBuilder: (context, index) {
                        final regimenItem = regimenDescription[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                                top: 25,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Medication form',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    regimenItem.medicationForm,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.darkGrey.withOpacity(.3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                                top: 25,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Dose',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    regimenItem.dose,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.darkGrey.withOpacity(.3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                                top: 25,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Pill time',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    regimenItem.pillTime,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.darkGrey.withOpacity(.3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                                top: 25,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Pill frequency',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    regimenItem.pillFrequency,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.darkGrey.withOpacity(.3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                                top: 25,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Duration',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    regimenItem.duration,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.darkGrey.withOpacity(.3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                                top: 25,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Notes',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    regimenItem.notes,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.darkGrey.withOpacity(.3),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
