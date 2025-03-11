import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/language_model.dart';
import '../utils/app_constants.dart';

class LocalizationController extends GetxController {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode);
  bool _isLtr = true;  // Default to LTR for English
  List<LanguageModel> _languages = [];
  int _selectedIndex = 0;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;
  int get selectedIndex => _selectedIndex;

  void setLanguage(Locale locale) {
    // Update the language and direction
    Get.updateLocale(locale);
    _locale = locale;
    _isLtr = (_locale.languageCode != 'ar' && _locale.languageCode != 'fr');
    saveLanguage(locale);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? AppConstants.languages[0].languageCode,
      sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? AppConstants.languages[0].countryCode,
    );
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstants.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(AppConstants.COUNTRY_CODE, locale.countryCode ?? "");
  }

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = AppConstants.languages;
    } else {
      _selectedIndex = -1;
      _languages = AppConstants.languages.where((language) {
        return language.languageName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    update();
  }
}