import 'package:flutter/cupertino.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';

/// This class helps to recognize user selected condition and check them
class ConditionsHelper {
  Map<String, bool>? _selectedCondition;
  final List<String>? translatedStrings;

  ConditionsHelper({this.translatedStrings});

  String atLeast = Strings.AT_LEAST;
  String uppercaseLetter = Strings.UPPERCASE_LETTER;
  String numericCharacter = Strings.NUMERIC_CHARACTER;
  String specialCharacter = Strings.SPECIAL_CHARACTER;

  /// Recognize user selected condition from widget constructor to put them on map with their value
  void setSelectedCondition(int minLength, uppercaseCharCount, numericCharCount, specialCharCount) {
    if (translatedStrings != null) {
      if (this.translatedStrings!.length > 0) {
        atLeast = this.translatedStrings![0];
        uppercaseLetter = this.translatedStrings![1];
        numericCharacter = this.translatedStrings![2];
        specialCharacter = this.translatedStrings![3];
      }
    }

    _selectedCondition = {
      if (minLength > 0) atLeast: false,
      if (uppercaseCharCount > 0) uppercaseLetter: false,
      if (numericCharCount > 0) numericCharacter: false,
      if (specialCharCount > 0) specialCharacter: false,
    };
  }

  /// Checks condition new value and passed validator, sets that in map and return new value;
  dynamic checkCondition(
      int userRequestedValue, Function validator, TextEditingController controller, String key, dynamic oldValue) {
    dynamic newValue;

    /// If the userRequested Value is grater than 0 that means user select them and we have to check new value;
    if (userRequestedValue > 0) {
      newValue = validator(controller.text, userRequestedValue);
    } else
      newValue = null;

    if (newValue == null)
      return null;
    else if (newValue != oldValue) {
      _selectedCondition![key] = newValue;
      return newValue;
    } else
      return oldValue;
  }

  Map<String, bool>? getter() => _selectedCondition;
}
