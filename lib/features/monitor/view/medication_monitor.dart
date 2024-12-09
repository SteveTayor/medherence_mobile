import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import '../../../core/shared_widget/buttons.dart';
import '../../../core/utils/size_manager.dart';
import '../view_model/monitor_viewmodel.dart';

// class MedicationCameraScreen extends StatefulWidget {
//   @override
//   _MedicationCameraScreenState createState() => _MedicationCameraScreenState();
// }

// class _MedicationCameraScreenState extends State<MedicationCameraScreen> {
//   late CameraController _cameraController;
//   Future<void>? _initializeControllerFuture;
//   bool _isDetecting = false;
//   String _snackBarMessage = "Hold your medication to the camera";

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   void _initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.first;

//     _cameraController = CameraController(
//       camera,
//       ResolutionPreset.high,
//     );

//     _initializeControllerFuture = _cameraController.initialize().then((_) {
//       setState(() {});
//     });

//     // Add your AI model initialization here

//     // Start detection loop
//     _startDetection();
//   }

//   void _startDetection() async {
//     // Simulate detection logic with delays
//     Future.delayed(Duration(seconds: 3), () {
//       setState(() {
//         _snackBarMessage = "Focus your camera on your mouth";
//       });
//     });
//     Future.delayed(Duration(seconds: 6), () {
//       setState(() {
//         _snackBarMessage = "Bravo!! You have used the medication";
//         _isDetecting = false;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 CameraPreview(_cameraController),
//                 Center(
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.green, width: 3),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     margin: EdgeInsets.all(20),
//                     child: SnackBar(
//                       content: Text(_snackBarMessage),
//                       duration: Duration(seconds: 2),
//                     ),
//                   ),
//                 ),
//                 if (!_isDetecting)
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: PrimaryButton(
//                         buttonConfig: ButtonConfig(
//                             text: 'Finish',
//                             action: () {
//                               Navigator.of(context).pushAndRemoveUntil(
//                                   MaterialPageRoute(
//                                     builder: (context) => DashboardView(),
//                                   ),
//                                   (route) => false);
//                             }),
//                         width: SizeMg.screenWidth - 60,
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

class MedicationAdherenceScreen extends StatefulWidget {
  const MedicationAdherenceScreen({super.key});

  @override
  _MedicationAdherenceScreenState createState() =>
      _MedicationAdherenceScreenState();
}

class _MedicationAdherenceScreenState extends State<MedicationAdherenceScreen> {
  late MedicationAdherenceViewModel viewModel;
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    viewModel = MedicationAdherenceViewModel();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    _cameraController?.initialize().then((_) {
      setState(() {});
    });

    // Add your AI model initialization here

    // Start detection loop
    // _startDetection();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        body: Consumer<MedicationAdherenceViewModel>(
          builder: (context, model, child) {
            return Stack(
              children: [
                // _cameraController?.value.isInitialized
                //     ?
                CameraPreview(_cameraController!),
                // Center(child: CircularProgressIndicator()),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                    ),
                    width: 200,
                    height: 200,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Visibility(
                    visible: !model.isMedicationDetected,
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "Hold your medication to the camera",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Visibility(
                    visible:
                        model.isMedicationDetected && !model.isMedicationUsed,
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "Focus your camera on your mouth",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Visibility(
                    visible: model.isMedicationUsed,
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "Bravo!! You have used the medication",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: (MediaQuery.of(context).size.width / 2) - 70,
                  child:
                      // ElevatedButton(
                      //   onPressed:
                      //       model.isScanning ? model.finishScan : model.startScan,
                      //   child:
                      //       Text(model.isScanning ? "Finish" : "Scan Medication"),
                      // ),
                      PrimaryButton(
                    buttonConfig: ButtonConfig(
                        text: 'Finish',
                        action: model.isScanning
                            ? model.finishScan(context)
                            : model.startScan),
                    width: SizeMg.screenWidth - 60,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
