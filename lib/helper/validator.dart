class Validator {
  static bool checkName(String x) {
    bool containsLetters = false;
    containsLetters = RegExp(r"^(?=.*?[أ-ي])").hasMatch(x) ||
        RegExp(r"^(?=.*?[A-z])").hasMatch(x);
    return containsLetters && x.length >= 5;
  }

  static bool checkNumber(String x) {
    try {
      double.parse(x.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool checkPassword(String password) {
    return RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*-~]).{8,}$')
        .hasMatch(password);
  }

  static bool checkEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool checkDescription(String description) {
    return RegExp(r"[أ-ي]").hasMatch(description) ||
        RegExp(r"[A-z]").hasMatch(description);
  }

  static bool checkProductName(String name) {
    return RegExp(r"[أ-ي]").hasMatch(name) || RegExp(r"[A-z]").hasMatch(name);
  }

  static bool checkPrice(String price) {
    try {
      double.parse(price);
      return true;
    } catch (e) {
      return false;
    }
  }
}
