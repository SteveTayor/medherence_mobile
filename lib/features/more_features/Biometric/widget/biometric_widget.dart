import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/model/models/wallet_model.dart';
import '../../../../core/service/biometric_service.dart';
import '../../../../core/shared_widget/buttons.dart';
import '../../../../core/utils/color_utils.dart';
import '../../../../core/utils/size_manager.dart';
import '../../../medhecoin/view_model/medhecoin_wallet_view_model.dart';
import '../../../monitor/view_model/reminder_view_model.dart';
import '../../../profile/view_model/profile_view_model.dart';
import '../../withdrawal/widget/transaction_successful_widget.dart';

class BiometricWidget extends StatefulWidget {
  const BiometricWidget({Key? key}) : super(key: key);

  @override
  _BiometricWidgetState createState() => _BiometricWidgetState();
}

class _BiometricWidgetState extends State<BiometricWidget> {
  final BiometricService _biometricService = BiometricService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10.withOpacity(0.6),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildFingerprintIcon(),
              const SizedBox(height: 10),
              const Text(
                'Use Fingerprint',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              if (_isLoading) const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFingerprintIcon() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          if (mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return _buildBiometricConfirmationDialog();
              },
            );
          }
        },
        child: SizedBox(
          child: Image.asset(
            'assets/images/fingerprint_sensor.png',
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }

  Widget _buildBiometricConfirmationDialog() {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Confirm Transaction',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ),
      content: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  bool isAuthenticated = await _biometricService.authenticate();
                  if (isAuthenticated) {
                    Navigator.pop(context); // Close the dialog if authenticated
                    _startLoadingAndProceed(context);
                  } else {
                    // Handle failed authentication
                  }
                },
                child: Image.asset(
                  'assets/images/fingerprint_sensor.png',
                  height: SizeMg.height(60),
                  width: SizeMg.width(60),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Touch the fingerprint sensor',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.bottomCenter,
                child: OutlinePrimaryButton(
                  width: 200,
                  textSize: SizeMg.text(16),
                  buttonConfig: ButtonConfig(
                    text: 'Cancel',
                    action: () {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startLoadingAndProceed(BuildContext context) {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });

      final walletViewModel =
          Provider.of<WalletViewModel>(context, listen: false);
      final profile = Provider.of<ProfileViewModel>(context, listen: false);
      final monitor = Provider.of<ReminderState>(context, listen: false);

      // Create a new transaction model
      final newTransaction = WalletModel(
        firstName: profile.nickName.isNotEmpty ? profile.nickName : 'ADB',
        lastName: '',
        src: 'assets/images/bank_logo/medherence_icon.png',
        title: 'Withdrawal',
        dateTime: DateTime.now().toString(),
        price: walletViewModel.totalAmount!.toDouble(),
        debit: true,
      );

      // Add the new transaction to the wallet model list
      walletViewModel.addTransaction(newTransaction);

      // Navigate to successful transaction screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SuccessfulTransaction(
            amount: walletViewModel.totalAmount?.toStringAsFixed(2) ?? '0.00',
          ),
        ),
        (Route<dynamic> route) => false,
      );

      // Deduct medcoin from the monitor
      monitor.deductMedcoin(walletViewModel.totalAmount!.toInt());
    });
  }
}
