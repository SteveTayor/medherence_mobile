import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import '../../../core/shared_widget/buttons.dart';
import '../../../core/utils/size_manager.dart';
import '../../dashboard_feature/view/dashboard_view.dart';

class MedicationCameraScreen extends StatefulWidget {
  @override
  _MedicationCameraScreenState createState() => _MedicationCameraScreenState();
}

class _MedicationCameraScreenState extends State<MedicationCameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _isDetecting = false;
  String _snackBarMessage = "Hold your medication to the camera";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _cameraController.initialize().then((_) {
      setState(() {});
    });

    // Add your AI model initialization here

    // Start detection loop
    _startDetection();
  }

  void _startDetection() async {
    // Simulate detection logic with delays
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _snackBarMessage = "Focus your camera on your mouth";
      });
    });
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        _snackBarMessage = "Bravo!! You have used the medication";
        _isDetecting = false;
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_cameraController),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: SnackBar(
                      content: Text(_snackBarMessage),
                      duration: Duration(seconds: 2),
                    ),
                  ),
                ),
                if (!_isDetecting)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PrimaryButton(
                        buttonConfig: ButtonConfig(
                            text: 'Finish',
                            action: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => DashboardView(),
                                  ),
                                  (route) => false);
                            }),
                        width: SizeMg.screenWidth - 60,
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// class MedicationAdherenceScreen extends StatefulWidget {
//   @override
//   _MedicationAdherenceScreenState createState() =>
//       _MedicationAdherenceScreenState();
// }

// class _MedicationAdherenceScreenState extends State<MedicationAdherenceScreen> {
//   final viewModel = MedicationAdherenceViewModel();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Camera Preview (implement using camera plugin or CameraService)
//           Center(
//             child: Container(
//               // Center overlay for medication placement
//               child: Stack(
//                 children: [
//                   // Transparent overlay with visual cue (dotted box, target symbol)
//                   // Medication detection logic based on viewModel.isMedicationDetected
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 50, // Adjust positioning as needed
//             left: 10, // Adjust positioning as needed
//             child: Visibility(
//               // Optional Top SnackBar
//               visible: !viewModel.isScanning,
//               child: Text("Hold your medication to the camera"),
//             ),
//           ),
//           Positioned(
//             bottom: 20, // Adjust positioning as needed
//             left: (MediaQuery.of(context).size.width / 2) - 40, // Center button
//             child: ElevatedButton(
//               onPressed: viewModel.isScanning
//                   ? viewModel.finishScan
//                   : viewModel.startScan,
//               child: Text(viewModel.isScanning ? "Finish" : "Scan Medication"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
