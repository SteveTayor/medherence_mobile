import 'package:flutter/material.dart';

import '../../dashboard_feature/view/dashboard_view.dart';

class MedicationAdherenceViewModel extends ChangeNotifier {
  bool isCameraInitialized = false;
  bool isScanning = false;
  bool isMedicationDetected = false;
  bool isMedicationUsed = false;

  void startScan() async {
    isScanning = true;
    isMedicationDetected = false;
    isMedicationUsed = false;
    // Simulated detection logic
    Future.delayed(const Duration(seconds: 3), () {
      isMedicationDetected = true;
      notifyListeners();
    });

    Future.delayed(const Duration(seconds: 6), () {
      isMedicationUsed = true;
      notifyListeners();
    });

    notifyListeners();
  }

  finishScan(BuildContext context) {
    isScanning = false;
    isMedicationDetected = false;
    isMedicationUsed = false;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const DashboardView(),
        ),
        (route) => false);
    notifyListeners();
  }
}
