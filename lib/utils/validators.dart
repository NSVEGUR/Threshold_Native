class Validators {
  // ignore: non_constant_identifier_names
  static final RegExp _MobileRegExp = RegExp(
    r'^[789]\d{9}$',
  );

  static isValidUserName(String userName) {
    return userName.length >= 5;
  }

  static isValidPassword(String password) {
    return password.length >= 8;
  }

  static isValidMobile(String mobile) {
    return _MobileRegExp.hasMatch(mobile);
  }

  static isSimilar(String password, String confirmPassword) {
    return password == confirmPassword &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }
}
