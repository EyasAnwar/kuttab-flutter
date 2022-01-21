import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {

  static SharedPreferencesController instance = SharedPreferencesController._();
  late SharedPreferences sharedPreferences;

  SharedPreferencesController._();

  factory SharedPreferencesController() {
    return instance;
  }

  Future<void> initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String get languageCode => sharedPreferences.getString('language_code') ?? 'ar';

  Future<bool> setLanguage(String languageCode) async {
    return await sharedPreferences.setString('language_code', languageCode);
  }


  Future<bool> setName(String name) async {
    return await sharedPreferences.setString('name', name);
  }

  Future<bool> setGender(String gender) async {
    return await sharedPreferences.setString('gender', gender);
  }

  Future<bool> setCityId(int cityId) async {
    return await sharedPreferences.setInt('cityId', cityId);
  }

  // Future<void> save({required User user}) async {
  //   await sharedPreferences.setBool('logged_in', true);
  //   await sharedPreferences.setInt('id', user.id);
  //   await sharedPreferences.setString('name', user.name);
  //   await sharedPreferences.setString('gender', user.gender);
  //   await sharedPreferences.setString('token', "Bearer ${user.token}");
  //   await sharedPreferences.setString('mobile', user.mobile);
  //   await sharedPreferences.setBool('active', user.active);
  //   await sharedPreferences.setInt('cityId', user.cityId);
  //   await sharedPreferences.setString('email', user.email??'');
  //   await sharedPreferences.setBool('verified', user.verified);
  //   await sharedPreferences.setInt('storeId', user.storeId);
  // }
  //
  // User? get user {
  //   User user = User();
  //   user.id = sharedPreferences.getInt('id') ?? 0;
  //   user.name = sharedPreferences.getString('name') ?? '';
  //   user.gender = sharedPreferences.getString('gender') ?? '';
  //   user.token = sharedPreferences.getString('token') ?? '';
  //   user.mobile = sharedPreferences.getString('mobile') ?? '';
  //   user.active = sharedPreferences.getBool('active') ?? false;
  //   user.cityId = sharedPreferences.getInt('cityId') ?? 0;
  //   user.email = sharedPreferences.getString('email') ?? '';
  //   user.verified = sharedPreferences.getBool('verified') ?? false;
  //   user.storeId = sharedPreferences.getInt('storeId') ?? 0;
  //   return user;
  // }

  bool get loggedIn => sharedPreferences.getBool('logged_in') ?? false;
  String get token => sharedPreferences.getString('accessTokenValue') ?? '';




  Future<bool> logout() async {
    return await sharedPreferences.clear();
  }
}