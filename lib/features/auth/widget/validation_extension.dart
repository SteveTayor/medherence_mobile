extension StringExtension on String? {
  String? nameValidation() {
    if (this == null || this!.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? emailValidation() {
    if (this == null || this!.isEmpty) {
      return 'Email cannot be empty';
    }
    return null;
  }

  String? validatePin() {
    if (this == null || this!.isEmpty) {
      return 'PIN cannot be empty';
    }
    if (this!.length != 4) {
      return 'PIN must be 4 digits long';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(this!)) {
      return 'PIN must be numeric';
    }
    return null;
  }

  String? phoneNumberValidation() {
    if (this == null || this!.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (this!.length < 11) {
      return 'Phone number cannot be less than 11 numbers';
    }
    if (this!.length > 11) {
      return 'Phone number cannot be greater than 11 numbers';
    }
    return null;
  }

  String? validatePassword() {
    if (this == null || this!.isEmpty) {
      return 'Password is required.';
    }
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(this!);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(this!);
    final hasNumber = RegExp(r'[0-9]').hasMatch(this!);
    final hasSpecialCase = RegExp(r'[!@#\$%^&*]').hasMatch(this!);
    if (this!.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    // Check for uppercase letters
    if (!hasUppercase) {
      return 'Password must include at least one uppercase letter.';
    }

    // Check for lowercase letters
    if (!hasLowercase) {
      return 'Password must include at least one lowercase letter.';
    }

    // Check for numbers
    if (!hasNumber) {
      return 'Password must include at least one number.';
    }

    // Check for special characters
    if (!hasSpecialCase) {
      return 'Password must include at least one special character.';
    }
    // You can add more specific password validation rules here
    return null;
  }
}
