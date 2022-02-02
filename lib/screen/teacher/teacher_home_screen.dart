import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:quran/getx_controller/login_getx_controller.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/achievement.dart';
import 'package:quran/models/attendance.dart';
import 'package:quran/models/resone.dart';
import 'package:quran/models/school.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/screen/teacher/teacher_profile_screen.dart';
import 'package:quran/screen/teacher/student_attendance_screen.dart';
import 'package:quran/widgets/app_text_field.dart';
import 'package:quran/widgets/bottom_sheet.dart';

import '../common/school_data_screen.dart';
import 'student_profile_screen.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  TeacherGetxController _teacherGetxController =
      Get.put(TeacherGetxController());
  late TextEditingController _reasonController;
  late TextEditingController _searchController;
  String? dropdownValue;
  List<dynamic> surahList = [];
  List<bool> userStats = [];
  final surahStorage = GetStorage();

  @override
  void initState() {
    _reasonController = TextEditingController();
    _searchController = TextEditingController();
    _teacherGetxController.getUserLogin();
    _teacherGetxController.getSchool();
    _teacherGetxController.getResone();
    _teacherGetxController.getStudentAchievement(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        lastRecord: 'quraan');
    var result = surahStorage.read('surahList');
    dynamic jsonData = jsonDecode(result);
    surahList = jsonData.map((surah) => Surah.fromJson(surah)).toList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _reasonController.dispose();
    _searchController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image background
          Container(
              color: Color(0xFF6AC891),
              child: Image.asset('images/app_header.png')),
          // body content
          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 65.h),
                    // Full name
                    GetBuilder<TeacherGetxController>(
                      builder: (context) {
                        return Text(
                          _teacherGetxController.school.name,
                          style: TextStyle(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF103E1C)),
                        );
                      },
                    ),
                    // Address
                    GetBuilder<TeacherGetxController>(
                      builder: (context) {
                        return Text(
                          _teacherGetxController.school.address,
                          style:
                              TextStyle(fontSize: 18.sp, color: Color(0xFF103E1C)),
                        );
                      },
                    ),
                    SizedBox(height: 25.h),
                    // Row Button (by user type)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            TeacherGetxController.to.setAttendance(
                                context,
                                Attendance(
                                    isAttended: true,
                                    date: DateTime.now().toString(),
                                    reason: 'No reason',
                                    userId: SharedPreferencesController()
                                        .user!
                                        .id
                                        .toString()));
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/calendar2_icon.svg',
                                color: Colors.green,
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "تسجيل الحضور",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(215.w, 50.h),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(
                                  color: Color(0xff2DBB66),
                                  width: 1.w,
                                )),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        ElevatedButton(
                          onPressed: () {
                            showAbsenceDialog(context, _reasonController);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/calendar2_icon.svg',
                                color: Colors.green,
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "تسجيل الغياب",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100.w, 50.h),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(
                                  color: Color(0xff2DBB66),
                                  width: 1.w,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    // Row search
                    Row(
                      children: [
                        // List title (by user type)
                        Text(
                          "الطلاب",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudentAttendanceScreen(
                                          isAttendance: userStats,
                                        )));
                          },
                          child: SvgPicture.asset(
                            'images/calendar2_icon.svg',
                            color: Colors.white,
                            width: 25.w,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(70, 50),
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        // Search
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border:
                                Border.all(width: 1.w, color: Color(0xFFE4E6EA)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  TeacherGetxController.to.searchStudent(
                                      context: context,
                                      username: _searchController.text);
                                },
                                child: SvgPicture.asset(
                                  'images/search_icon.svg',
                                  color: Colors.green,
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Container(
                                width: 125.w,
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    disabledBorder: InputBorder.none,
                                    hintText: 'بحث عن طالب',
                                    hintStyle: TextStyle(fontSize: 14.sp),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Time
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFF2CBB66).withOpacity(0.3),
                      ),
                      width: double.infinity,
                      height: 25.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/calendar_icon.svg',
                            color: Colors.green,
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            DateFormat('EEEE')
                                    .format(DateTime.now())
                                    .toString() +
                                "   " +
                                DateFormat('dd-MM-yyyy')
                                    .format(DateTime.now())
                                    .toString(),
                            style: TextStyle(
                                color: Color(0xFF2CBB66),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // List
                    Expanded(
                      child: GetX<TeacherGetxController>(
                        builder: (controller) {
                          if (controller.achievementList.isNotEmpty) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                userStats.add(controller
                                    .achievementList[index].isAttendance);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentProfileScreen(
                                                  id: controller
                                                      .achievementList[index]
                                                      .id,
                                                  school_id:
                                                      _teacherGetxController
                                                          .school.id,
                                                  isAttendance:
                                                      _teacherGetxController
                                                          .achievementList[
                                                              index]
                                                          .isAttendance,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xFFF9F9F9),
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          width: 55.w,
                                          height: 55.h,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://kuttab.sirius-it.dev/storage/" +
                                                      controller
                                                          .achievementList[
                                                              index]
                                                          .image),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              width: 2.w,
                                              color: controller
                                                      .achievementList[index]
                                                      .isRecord
                                                  ? controller
                                                              .achievementList[
                                                                  index]
                                                              .isAttendance ==
                                                          true
                                                      ? controller
                                                              .achievementList[
                                                                  index]
                                                              .isDailyRecord
                                                          ? Color(0xFF2CBC67)
                                                          : Color(0xFFF39C12)
                                                      : Color(0xFFE74C3C)
                                                  : Colors.blueGrey,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          controller.achievementList[index]
                                                  .firstName +
                                              " " +
                                              controller.achievementList[index]
                                                  .middleName +
                                              " " +
                                              controller.achievementList[index]
                                                  .lastName,
                                          style: TextStyle(
                                              color: Color(0xFF103E1C),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          controller.achievementList[index]
                                                  .isRecord
                                              ? controller.achievementList[index].isAttendance ==
                                                      true
                                                  ? controller
                                                              .achievementList[
                                                                  index]
                                                              .isDailyRecord ==
                                                          true
                                                      ? getType(controller
                                                              .achievementList[
                                                                  index]
                                                              .lastRecord!
                                                              .typeId) +
                                                          ": " +
                                                          getSurah(
                                                                  int.parse(controller
                                                                      .achievementList[
                                                                          index]
                                                                      .lastRecord!
                                                                      .fromSura),
                                                                  surahList)
                                                              .name +
                                                          " " +
                                                          controller
                                                              .achievementList[
                                                                  index]
                                                              .lastRecord!
                                                              .fromAya
                                                              .toString() +
                                                          " - " +
                                                          getSurah(
                                                                  int.parse(controller
                                                                      .achievementList[
                                                                          index]
                                                                      .lastRecord!
                                                                      .toSura),
                                                                  surahList)
                                                              .name +
                                                          " " +
                                                          controller
                                                              .achievementList[index]
                                                              .lastRecord!
                                                              .toAya
                                                              .toString()
                                                      : 'لم يسمع'
                                                  : 'غائب'
                                              : 'لا يوجد سجل',
                                          style: TextStyle(
                                              color: Color(0xFF103E1C),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.achievementList.length,
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 80,
                                    color: Colors.grey.shade500,
                                  ),
                                  Text(
                                    'لا يوجد طلاب',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Header content
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                    child: GetBuilder<TeacherGetxController>(
                      builder: (context) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://kuttab.sirius-it.dev/storage/" +
                                  _teacherGetxController.userLogin.image),
                          radius: 25,
                        );
                      },
                    ),
                  ),
                  title: Text(
                    "السلام عليكم",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                  subtitle: GetBuilder<TeacherGetxController>(builder: (logic) {
                    return Text(
                        _teacherGetxController.userLogin.first_name +
                            " " +
                            _teacherGetxController.userLogin.last_name,
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold));
                  }),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black38,
                    ),
                    padding: EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      'images/notification_icon.svg',
                      color: Colors.white,
                      width: 25.w,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SchoolDataScreen(school: school)));
                },
                child: GetBuilder<TeacherGetxController>(builder: (logic) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://kuttab.sirius-it.dev/" +
                            _teacherGetxController.school.logo),
                    radius: 55,
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showAbsenceDialog(BuildContext context, var _reasonController) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'images/cancel_icon.svg',
                                color: Colors.white,
                                width: 10.w,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'اذن الغياب',
                          style:
                          TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 20.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'images/achievement_icon.svg',
                          color: Colors.green,
                          width: 20.w,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'سبب الغياب',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 1.w, color: Color(0xFFE4E6EA)),
                      ),
                      width: double.infinity,
                      height: 60.h,
                      child: Center(
                        child: DropdownButton<String>(
                          value: dropdownValue ??
                              _teacherGetxController.reasonsList2[0],
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                          underline: Container(
                            height: 2.h,
                            color: Colors.white,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: _teacherGetxController.reasonsList2
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextFiled(
                        controller: _reasonController,
                        hint: "ادخل سبب الغياب",
                        icon: "images/note_icon.svg",
                        textFiledTitle: "سبب الغياب"),
                    SizedBox(
                      height: 40.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        TeacherGetxController.to.setAttendance(
                            context,
                            Attendance(
                                isAttended: false,
                                date: DateTime.now().toString(),
                                reason: dropdownValue == 'غير محدد' ? _reasonController.text : dropdownValue,
                                userId: SharedPreferencesController()
                                    .user!
                                    .id
                                    .toString()));
                      },
                      child: Text(
                        'الاذن',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        primary: Color(0xFF2CBC67),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  School get school {
    School school = School();
    school.name = _teacherGetxController.school.name;
    school.logo = _teacherGetxController.school.logo;
    school.address = _teacherGetxController.school.address;
    school.description = _teacherGetxController.school.description;
    return school;
  }

  String getType(int typeID) {
    return typeID == 1
        ? 'حفظ'
        : typeID == 3
            ? "تلاوة"
            : typeID == 2
                ? "مراجعة"
                : '';
  }

  Surah getSurah(int number, List<dynamic> list) {
    Surah? result;
    for (Surah surah in list) {
      if (surah.number == number) {
        result = surah;
        break;
      }
    }
    return result!;
  }
}
