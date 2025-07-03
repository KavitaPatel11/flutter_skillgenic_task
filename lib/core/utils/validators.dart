class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
