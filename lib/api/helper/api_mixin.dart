import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/utils/helper.dart';


mixin ApiMixin {

  Uri getUrl(String url) {
    return Uri.parse(url);
  }

  bool isSuccessRequest(int statusCode) {
    return statusCode < 400;
  }

  void handleServerError(BuildContext context) {
    Helper.showSnackBar(context, text: 'Unable to perform your request now!', error: true);
  }

  void showMessage(BuildContext context, Response response, {bool error = false}) {
    Helper.showSnackBar(context, text: jsonDecode(response.body)['message'], error: error);
  } // ??

  Map<String, String> get requestHeaders {
    return {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'lang': SharedPreferencesController().languageCode
    };
  }

  Map<String, String> get baseHeader {
    return {
      'X-Requested-With': 'XMLHttpRequest',
      'lang': SharedPreferencesController().languageCode
    };
  }

  Map<String, String> get header {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${SharedPreferencesController().token}',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    };
  }
  Map<String, String> get jsonHeader {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${SharedPreferencesController().token}',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json',
      'Content-Type':'application/json'

    };
  }

  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${SharedPreferencesController().token}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  Map<String, String> get headerNotification {
    return {

      'Accept': 'application/json'
    };
  }

}
