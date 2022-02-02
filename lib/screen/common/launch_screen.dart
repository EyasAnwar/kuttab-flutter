import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/models/user.dart';
import 'package:quran/screen/parent/parent_home_screen.dart';
import 'package:quran/utils/helper.dart';

import '../parent/parent_home_screen.dart';
import '../student/student_home_screen.dart';
import '../teacher/teacher_home_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if(SharedPreferencesController().firstTime){
        storeSurah();
        SharedPreferencesController().setFirstTime(firstTime: false);
      }

      if(SharedPreferencesController().loggedIn){
        User? user = SharedPreferencesController().user;
        if(user!.type == 'parent'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ParentHomeScreen()));
        }else if(user.type == 'teacher'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeacherHomeScreen()));
        }else if(user.type == 'student'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentHomeScreen()));
        }else{
          Helper.showSnackBar(context, text: 'حدث خطا ما', error: true);
        }
      }else{
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('images/logo.png'),
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('images/logo.svg',color: Colors.green, width: 150.w,)
          ),
        ],
      ),
    );
  }

  Future<void> storeSurah() async{
    final surahStorage = GetStorage();
    List<Surah> surahList = <Surah>[
      Surah(number: 1, name: 'الفاتحة', numberOfAya: 7),
      Surah(number: 2, name: 'البقرة', numberOfAya: 286),
      Surah(number: 3, name: 'ال عمران', numberOfAya: 200),
      Surah(number: 4, name: 'النساء', numberOfAya: 176),
      Surah(number: 5, name: 'المائدة', numberOfAya: 120),
      Surah(number: 6, name: 'الانعام', numberOfAya: 165),
      Surah(number: 7, name: 'الاعراف', numberOfAya: 206),
      Surah(number: 8, name: 'الانفال', numberOfAya: 75),
      Surah(number: 9, name: 'التوبة', numberOfAya: 129),
      Surah(number: 10, name: 'يونس', numberOfAya: 109),
      Surah(number: 11, name: 'هود', numberOfAya: 123),
      Surah(number: 12, name: 'يوسف', numberOfAya: 111),
      Surah(number: 13, name: 'الرعد', numberOfAya: 43),
      Surah(number: 14, name: 'ابراهيم', numberOfAya: 52),
      Surah(number: 15, name: 'الحجر', numberOfAya: 99),
      Surah(number: 16, name: 'النحل', numberOfAya: 128),
      Surah(number: 17, name: 'الاسراء', numberOfAya: 111),
      Surah(number: 18, name: 'الكهف', numberOfAya: 110),
      Surah(number: 19, name: 'مريم', numberOfAya: 98),
      Surah(number: 20, name: 'طه', numberOfAya: 135),
      Surah(number: 21, name: 'الأنبياء', numberOfAya: 112),
      Surah(number: 22, name: 'الحج', numberOfAya: 78),
      Surah(number: 23, name: 'المؤمنون', numberOfAya: 118),
      Surah(number: 24, name: 'النور', numberOfAya: 64),
      Surah(number: 25, name: 'الفرقان', numberOfAya: 77),
      Surah(number: 26, name: 'الشعراء', numberOfAya: 227),
      Surah(number: 27, name: 'النمل', numberOfAya: 93),
      Surah(number: 28, name: 'القصص', numberOfAya: 88),
      Surah(number: 29, name: 'العنكبوت', numberOfAya: 69),
      Surah(number: 30, name: 'الروم', numberOfAya: 60),
      Surah(number: 31, name: 'لقمان', numberOfAya: 34),
      Surah(number: 32, name: 'السجدة', numberOfAya: 30),
      Surah(number: 33, name: 'الاحزاب', numberOfAya: 73),
      Surah(number: 34, name: 'سبأ', numberOfAya: 54),
      Surah(number: 35, name: 'فاطر', numberOfAya: 45),
      Surah(number: 36, name: 'يس', numberOfAya: 38),
      Surah(number: 37, name: 'الصافات', numberOfAya: 182),
      Surah(number: 38, name: 'ص', numberOfAya: 88),
      Surah(number: 39, name: 'الزمر', numberOfAya: 75),
      Surah(number: 40, name: 'غافر', numberOfAya: 85),
      Surah(number: 41, name: 'فصلت', numberOfAya: 54),
      Surah(number: 42, name: 'الشورى', numberOfAya: 53),
      Surah(number: 43, name: 'الزخرف', numberOfAya: 89),
      Surah(number: 44, name: 'الدخان', numberOfAya: 59),
      Surah(number: 45, name: 'الجاثية', numberOfAya: 37),
      Surah(number: 46, name: 'الأحقاف', numberOfAya: 35),
      Surah(number: 47, name: 'محمد', numberOfAya: 38),
      Surah(number: 48, name: 'الفتح', numberOfAya: 29),
      Surah(number: 49, name: 'الحجرات', numberOfAya: 18),
      Surah(number: 50, name: 'ق', numberOfAya: 45),
      Surah(number: 51, name: 'الذاريات', numberOfAya: 60),
      Surah(number: 52, name: 'الطور', numberOfAya: 49),
      Surah(number: 53, name: 'النجم', numberOfAya: 62),
      Surah(number: 54, name: 'القمر', numberOfAya: 55),
      Surah(number: 55, name: 'الرحمن', numberOfAya: 78),
      Surah(number: 56, name: 'الواقعة', numberOfAya: 96),
      Surah(number: 57, name: 'الحديد', numberOfAya: 29),
      Surah(number: 58, name: 'المجادلة', numberOfAya: 22),
      Surah(number: 59, name: 'الحشر', numberOfAya: 24),
      Surah(number: 60, name: 'الممتحنة', numberOfAya: 13),
      Surah(number: 61, name: 'الصف', numberOfAya: 14),
      Surah(number: 62, name: 'الجمعة', numberOfAya: 11),
      Surah(number: 63, name: 'المنافقون', numberOfAya: 11),
      Surah(number: 64, name: 'التغابن', numberOfAya: 18),
      Surah(number: 65, name: 'الطلاق', numberOfAya: 12),
      Surah(number: 67, name: 'التحريم', numberOfAya: 12),
      Surah(number: 68, name: 'الملك', numberOfAya: 30),
      Surah(number: 69, name: 'القلم', numberOfAya: 52),
      Surah(number: 70, name: 'الحاقة', numberOfAya: 52),
      Surah(number: 71, name: 'المعارج', numberOfAya: 44),
      Surah(number: 72, name: 'نوح', numberOfAya: 28),
      Surah(number: 73, name: 'الجن', numberOfAya: 28),
      Surah(number: 74, name: 'المزمل', numberOfAya: 20),
      Surah(number: 75, name: 'المدثر', numberOfAya: 56),
      Surah(number: 76, name: 'القيامة', numberOfAya: 40),
      Surah(number: 77, name: 'الانسان', numberOfAya: 31),
      Surah(number: 78, name: 'المرسلات', numberOfAya: 50),
      Surah(number: 79, name: 'النبأ', numberOfAya: 40),
      Surah(number: 80, name: 'النازعات', numberOfAya: 46),
      Surah(number: 81, name: 'عبس', numberOfAya: 42),
      Surah(number: 82, name: 'التكوير', numberOfAya: 29),
      Surah(number: 83, name: 'الانفطار', numberOfAya: 19),
      Surah(number: 84, name: 'المطففين', numberOfAya: 36),
      Surah(number: 85, name: 'الانشقاق', numberOfAya: 25),
      Surah(number: 86, name: 'البروج', numberOfAya: 22),
      Surah(number: 87, name: 'الطارق', numberOfAya: 17),
      Surah(number: 88, name: 'الاعلى', numberOfAya: 19),
      Surah(number: 89, name: 'الغاشية', numberOfAya: 26),
      Surah(number: 90, name: 'الفجر', numberOfAya: 30),
      Surah(number: 91, name: 'البلد', numberOfAya: 20),
      Surah(number: 92, name: 'الشمس', numberOfAya: 15),
      Surah(number: 93, name: 'الليل', numberOfAya: 21),
      Surah(number: 94, name: 'الضحى', numberOfAya: 11),
      Surah(number: 95, name: 'الشرح', numberOfAya: 8),
      Surah(number: 96, name: 'التين', numberOfAya: 5),
      Surah(number: 97, name: 'العلق', numberOfAya: 19),
      Surah(number: 98, name: 'القدر', numberOfAya: 5),
      Surah(number: 99, name: 'البينة', numberOfAya: 8),
      Surah(number: 100, name: 'الزلزلة', numberOfAya: 8),
      Surah(number: 101, name: 'العاديات', numberOfAya: 11),
      Surah(number: 102, name: 'القارعة', numberOfAya: 11),
      Surah(number: 103, name: 'التكاثر', numberOfAya: 8),
      Surah(number: 104, name: 'العصر', numberOfAya: 3),
      Surah(number: 105, name: 'الهمزة', numberOfAya: 9),
      Surah(number: 106, name: 'الفيل', numberOfAya: 5),
      Surah(number: 107, name: 'قريش', numberOfAya: 4),
      Surah(number: 108, name: 'الماعون', numberOfAya: 6),
      Surah(number: 109, name: 'الكوثر', numberOfAya: 3),
      Surah(number: 110, name: 'الكافرون', numberOfAya: 6),
      Surah(number: 111, name: 'النصر', numberOfAya: 3),
      Surah(number: 112, name: 'المسد', numberOfAya: 5),
      Surah(number: 113, name: 'الاخلاص', numberOfAya: 4),
      Surah(number: 114, name: 'الفلق', numberOfAya: 5),
      Surah(number: 115, name: 'الناس', numberOfAya: 6),
    ];

    // Storing data
    var surahAsMap = surahList.map((surah) => surah.toJson()).toList();
    String jsonString = jsonEncode(surahAsMap);
    await surahStorage.write('surahList', jsonString);
  }



}