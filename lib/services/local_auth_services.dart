import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthServices {
  static final _localAuth = LocalAuthentication();

  // MARK: - Check if device can authenticate
  static Future<bool> _checkDeviceCanAuthenticate() async {
    return await _localAuth.canCheckBiometrics || await _localAuth.isDeviceSupported();
  }

  // MARK: - Authenticate
  static Future<bool> authenticate() async {
    try {
      if (!await _checkDeviceCanAuthenticate()) return false;
      return await _localAuth.authenticate(
        localizedReason: "use biometric id to authenticate",
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );
    } catch (e) {
      debugPrint("🔴LocalAuth Error: $e");
      return false;
    }
  }
}
