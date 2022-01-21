import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';

class AppLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'hello': 'Hello World',
      'title': 'title',

    },
    'ar': {
      'hello': 'مرحباً',
      'title': 'العنوان',



    }
  };

  static void changeLang() {
    String newLanguageCode = SharedPreferencesController().languageCode == 'ar' ? 'en' : 'ar';
    Get.updateLocale(Locale(newLanguageCode));
    SharedPreferencesController().setLanguage(newLanguageCode);
  }
}