import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppLocalizations {
  static Locale? lastLocale;

  final Locale locale;

  AppLocalizations(this.locale) {
    AppLocalizations.lastLocale = locale;
    Intl.defaultLocale = locale.toString();

    timeago.setLocaleMessages("fr", timeago.FrShortMessages());
    timeago.setLocaleMessages("en", timeago.EnMessages());

    timeago.setDefaultLocale(locale.languageCode);
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Map<String, dynamic>? _localizedStrings;

  Future load() async {
    String jsonString = await rootBundle.loadString('assets/localizations/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value);
    });
  }

  String translate(String key, {Map<String, String?>? variables}) {
    var nestedMap = _getNestedValue(key);
    if (nestedMap is String) {
      nestedMap = this.replaceValues(nestedMap, variables);
    }
    return nestedMap.toString();
  }

  dynamic translateRaw(String key) {
    return _getNestedValue(key);
  }

  String replaceValues(String translation, Map<String, String?>? variables) {
    if (variables == null || variables.isEmpty) {
      return translation;
    }

    variables.forEach((key, value) {
      translation = translation.replaceAll("{{$key}}", value!);
    });

    return translation;
  }

  dynamic _getNestedValue(String keyPath) {
    final subKeys = keyPath.split(".");
    dynamic currentValue = _localizedStrings;
    while (subKeys.isNotEmpty) {
      if (currentValue == null) {
        return keyPath;
      }
      final currentKey = subKeys.removeAt(0);
      currentValue = currentValue[currentKey];
    }
    return currentValue ?? keyPath;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['fr', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
