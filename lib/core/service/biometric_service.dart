import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static bool isEnabled = false;
  // Initialize Local Authentication plugin.
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  // Status of authentication.
  bool isAuthenticated = false;

  /// Authenticates the user using biometric authentication.
  ///
  /// This method checks if biometric authentication is available on the device.
  /// If available, it prompts the user to authenticate using biometrics.
  ///
  /// Returns `true` if the authentication is successful, otherwise `false`.
  Future<bool> authenticate() async {
    try {
      // Check if the device can check biometrics.
      bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
      if (!canCheckBiometrics) {
        // Throw an exception if biometric authentication is not available.
        throw PlatformException(
          code: 'NotAvailable',
          message: 'Biometric authentication is not available on this device.',
        );
      }

      // If the device can check biometrics, prompt the user to authenticate.
      if (canCheckBiometrics) {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Please authenticate to confirm.',
          options: const AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      }
      return isAuthenticated;
    } on PlatformException catch (e) {
      // Handle the exception if authentication fails.
      print('Authentication failed: ${e.message}');
      return false;
    }
  }
}
