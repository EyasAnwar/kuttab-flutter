import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/firebase/fb_notifications.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/locale/app_locale.dart';
import 'package:quran/screen/common/about_screen.dart';
import 'package:quran/screen/common/all_achievements_screen.dart';
import 'package:quran/screen/teacher/edit_profile_screen.dart';
import 'package:quran/screen/common/edit_student_profile.dart';
import 'package:quran/screen/parent/parent_home_screen.dart';
import 'package:quran/screen/student/student_home_screen.dart';
import 'package:quran/screen/teacher/teacher_home_screen.dart';
import 'package:quran/screen/common/launch_screen.dart';
import 'package:quran/screen/common/login_screen.dart';
import 'package:quran/screen/common/privace_screen.dart';
import 'package:quran/screen/student/student_profile_screen.dart';
import 'package:quran/screen/teacher/teacher_profile_screen.dart';
import 'package:quran/screen/common/school_data_screen.dart';
import 'package:quran/screen/common/setting_screen.dart';
import 'package:quran/screen/teacher/student_attendance_screen.dart';
import 'package:quran/screen/teacher/student_profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SharedPreferencesController().initSharedPreference();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();
  await FbNotifications.initializeForegroundNotificationForAndroid();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),//your dimensions design(w,h)
      builder: () => GetMaterialApp(
        translations: AppLocale(), // your translations
        locale: Locale(SharedPreferencesController().languageCode),
        title: 'Hello'.tr,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch_screen',
        routes: {
          '/launch_screen':(context)=>LaunchScreen(),
          '/teacher_home_screen':(context)=>TeacherHomeScreen(),
          '/student_home_screen':(context)=>StudentHomeScreen(),
          '/parent_home_screen':(context)=>ParentHomeScreen(),
          '/student_profile_screen_2':(context)=>StudentProfileScreen2(),
          '/login_screen':(context)=>LoginScreen(),
          '/profile_screen':(context)=>ProfileScreen(),
          '/privacy_screen':(context)=>PrivacyScreen(),
          '/about_screen':(context)=>AboutScreen(),
          '/setting_screen':(context)=>SettingScreen(),
        },
      ),
    );
  }
}