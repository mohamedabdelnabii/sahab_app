import 'package:flutter/services.dart';

/// Allows only English characters (letters, numbers, spaces, and common punctuation)
class EnglishTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow English letters, numbers, spaces, and common punctuation
    final regExp = RegExp(r"^[a-zA-Z0-9\s\.,!?;:\-_()&@#$%']*$");

    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }

    // If the new text contains Arabic or other non-English characters, keep the old value
    return oldValue;
  }
}

/// Allows only Arabic characters (letters, numbers, spaces, and common punctuation)
class ArabicTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow Arabic letters, Arabic numbers, spaces, and common punctuation
    final regExp = RegExp(
      r"^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF0-9\s\.,!?;:\-_()&@#$%']*$",
    );

    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }

    // If the new text contains English letters, keep the old value
    return oldValue;
  }
}
