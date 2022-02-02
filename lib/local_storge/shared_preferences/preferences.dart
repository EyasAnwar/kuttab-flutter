import 'package:quran/models/class.dart';
import 'package:quran/models/school.dart';
import 'package:quran/models/user.dart';
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

  Future<void> saveUserData({required User user}) async {
    await sharedPreferences.setInt('id', user.id);
    await sharedPreferences.setBool('logged_in', true);
    await sharedPreferences.setString('token', user.token!);
    await sharedPreferences.setInt('user_school_id', user.school_id);
    await sharedPreferences.setString('type', user.type);
  }

  Future<void> setFirstTime({required bool firstTime}) async {
    await sharedPreferences.setBool('firstTime', false);
  }

  Future<void> saveSchoolData({required School school}) async {
    await sharedPreferences.setInt('school_id', school.id);
  }

  Future<void> saveClassData({required SchoolClass schoolClass}) async {
    await sharedPreferences.setString('class_name', schoolClass.name);
  }

  User? get user {
    User user = User();
    user.id = sharedPreferences.getInt('id') ?? 0;
    user.school_id = sharedPreferences.getInt('user_school_id') ?? 0;
    user.type = sharedPreferences.getString('type') ?? '';
    return user;
  }

  School? get school {
    School school = School();
    school.id = sharedPreferences.getInt('school_id') ?? 0;
    school.name = sharedPreferences.getString('school_title') ?? '';
    school.address = sharedPreferences.getString('school_address') ?? '';
    school.logo = sharedPreferences.getString('school_logo') ?? '';
    return school;
  }

  SchoolClass? get schoolClass {
    SchoolClass school = SchoolClass();
    school.name = sharedPreferences.getString('class_name') ?? '';
    return school;
  }

  bool get loggedIn => sharedPreferences.getBool('logged_in') ?? false;
  String get token => sharedPreferences.getString('token') ?? '';
  bool get firstTime => sharedPreferences.getBool('firstTime') ?? true;

  Future<bool> logout() async {
    return await sharedPreferences.clear();
  }
}