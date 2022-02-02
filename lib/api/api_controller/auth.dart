import 'dart:convert';

import 'package:quran/api/helper/api_mixin.dart';
import 'package:quran/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:quran/models/user.dart';

import '../api_settings.dart';

class AuthApiController with ApiMixin {

  Future<User> login({required Login login}) async {
    var response = await http.post(getUrl(ApiSettings.LOGIN), headers: header, body: {
      'username': login.username,
      'password': login.password,
    });
    if (isSuccessRequest(response.statusCode)) {
      User? user;
      try {
        User.fromJson(jsonDecode(response.body)['status']);
        return User();
      } catch (e) {
        user = User.fromJson(jsonDecode(response.body));
        print(user.token);
        return user;
      }
    } else {
      return User();
    }
  }

  Future<bool>logout() async {
    var response = await http.get(getUrl(ApiSettings.LOGIN), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else {
      return false;
    }
  }

}
