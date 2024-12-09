import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/size_manager.dart';
import '../wallet/widget/wallet_pin_widget.dart';
import '../../../core/utils/color_utils.dart';

class BiometricAuthenticationView extends StatefulWidget {
  const BiometricAuthenticationView({Key? key}) : super(key: key);

  @override
  _BiometricAuthenticationViewState createState() =>
      _BiometricAuthenticationViewState();
}

class _BiometricAuthenticationViewState
    extends State<BiometricAuthenticationView> {
  bool _isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricEnabledState();
  }

  Future<void> _loadBiometricEnabledState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isBiometricEnabled = prefs.getBool('useBiometric') ?? false;
    setState(() {}); // Update the UI with the loaded state
  }

  Future<void> _saveBiometricEnabledState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useBiometric', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biometric Authentication',
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
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enhance Your Wallet Security: Enable biometric authentication to Safeguard Your Earnings and Transactions',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              activeTrackColor: AppColors.success, // Added active track color
              title: const Text(
                'Enable Fingerprint',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: _isBiometricEnabled,
              onChanged: (value) async {
                setState(() {
                  _isBiometricEnabled = value;
                  _saveBiometricEnabledState(value); // Save preference
                });
                if (_isBiometricEnabled) {
                  await _showWalletPinDialog(); // Wait for pin confirmation
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showWalletPinDialog() async {
    final confirmed = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => const WalletPinWidget(),
    );
    if (confirmed != null && confirmed) {
      // User confirmed PIN, enable biometric authentication
      setState(() {
        _isBiometricEnabled = true;
      });
      _saveBiometricEnabledState(true); // Persist state
    } else {
      // User canceled or failed PIN verification, disable switch
      setState(() {
        _isBiometricEnabled = false;
      });
      _saveBiometricEnabledState(false); // Persist state
    }
  }
}
