import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:quran/api/api_controller/auth.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/login.dart';
import 'package:quran/models/user.dart';
import 'package:quran/screen/parent/parent_home_screen.dart';
import 'package:quran/screen/student/student_home_screen.dart';
import 'package:quran/screen/teacher/teacher_home_screen.dart';
import 'package:quran/screen/common/login_screen.dart';
import 'package:quran/screen/teacher/teacher_profile_screen.dart';
import 'package:quran/screen/teacher/student_attendance_screen.dart';
import 'package:quran/utils/helper.dart';

class LoginGetxController extends GetxController with Helper {
  AuthApiController _loginGetxController = AuthApiController();
  static LoginGetxController get to => Get.find();

  Future<bool> login({required BuildContext context, required Login login}) async {
    if (login.username.isNotEmpty && login.password.isNotEmpty) {
      User userLogin = await _loginGetxController.login(login: login);
      if(userLogin != null){
        await SharedPreferencesController().saveUserData(user: userLogin);
        print('type = ' + userLogin.type);
        if(userLogin.type == 'parent'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ParentHomeScreen()));
        }else if(userLogin.type == 'teacher'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeacherHomeScreen()));
        }else if(userLogin.type == 'student'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentHomeScreen()));
        }else{
          Helper.showSnackBar(context, text: 'حدث خطا ما', error: true);
          logout(context);
        }
        return true;
      }else{
        Helper.showSnackBar(context, text: 'تاكد من اسم المستخدم وكلمة المرور', error: true);
        return false;
      }
    }else{
      Helper.showSnackBar(context, text: 'ادخل البيانات المطلوبة', error: true);
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    bool state = await _loginGetxController.logout();
    if (state) {
      SharedPreferencesController().logout();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }else{
      Helper.showSnackBar(context, text: 'حدث خطا ما', error: true);
    }
  }

}
