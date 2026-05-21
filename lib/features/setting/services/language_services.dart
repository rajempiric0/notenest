import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String langKey = "languageCode";
  static const String countryKey = "countryCode";

  Future<void> saveLanguage(String langCode, String countryCode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(langKey, langCode);
    await prefs.setString(countryKey, countryCode);
  }

  Future<Locale> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    String langCode = prefs.getString(langKey) ?? 'en';
    String countryCode = prefs.getString(countryKey) ?? 'US';

    return Locale(langCode, countryCode);
  }

  Future<void> changeLanguage(
      String langCode,
      String countryCode,
      ) async {
    Locale locale = Locale(langCode, countryCode);

    Get.updateLocale(locale);

    await saveLanguage(langCode, countryCode);
  }
}