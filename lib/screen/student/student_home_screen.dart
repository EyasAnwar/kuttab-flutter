import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/attendance.dart';
import 'package:quran/models/daily_record.dart';
import 'package:quran/models/school.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/screen/common/all_achievements_screen.dart';
import 'package:quran/screen/student/student_profile_screen.dart';
import 'package:quran/widgets/app_text_field.dart';
import 'package:quran/widgets/bottom_sheet.dart';
import '../teacher/teacher_profile_screen.dart';
import '../common/school_data_screen.dart';
import '../teacher/student_attendance_screen.dart';
import 'student_report_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  TeacherGetxController _teacherGetxController = Get.put(TeacherGetxController());
  late TextEditingController _reasonController;
  String dropdownValue = "غير محدد";
  List<dynamic> surahList = [];
  final surahStorage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    _teacherGetxController.getUserLogin();
    _teacherGetxController.getSchool();
    _teacherGetxController.getResone();
    _teacherGetxController.getAllSingleStudentAchievement(from: DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days:2))).toString(), to: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(), id: SharedPreferencesController().user!.id);
    var result = surahStorage.read('surahList');
    dynamic jsonData = jsonDecode(result);
    surahList = jsonData.map((surah) => Surah.fromJson(surah)).toList();
    _reasonController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _reasonController.dispose();
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
              height: 680.h,
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
                    // Space
                    SizedBox(height: 65.h),
                    // Full name
                    GetBuilder<TeacherGetxController>(
                      builder: (context){
                        return Text(
                          _teacherGetxController.school.name,
                          style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold, color: Color(0xFF103E1C)),
                        );
                      },
                    ),
                    // Address
                    GetBuilder<TeacherGetxController>(
                      builder: (context){
                        return Text(
                          _teacherGetxController.school.address,
                          style: TextStyle(fontSize: 18.sp, color: Color(0xFF103E1C)),
                        );
                      },
                    ),
                    // Space
                    SizedBox(height: 25.h),
                    // Row Button (by user type)
                    ElevatedButton(
                      onPressed: () {showAbsenceDialog(context, _reasonController);},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            "اذن غياب",
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              color: Color(0xff2DBB66),
                              width: 1.w,
                            )),
                      ),
                    ),
                    // Space
                    SizedBox(height: 30.h),
                    // Row search (by user type)
                    Row(
                      children: [
                        Text(
                          "احدث الانجازات",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.sp),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ALLAchievementsScreen(id: SharedPreferencesController().user!.id, surahList: surahList,)));},
                          child: Text(
                            "عرض الكل",
                            style: TextStyle(color: Colors.green, fontSize: 16.sp),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SvgPicture.asset(
                          'images/forword_icon.svg',
                          color: Colors.green,
                          width: 13.w,
                        ),
                      ],
                    ),
                    // Space
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
                          Text(DateFormat('EEEE').format(DateTime.now()).toString() + "   " + DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(), style: TextStyle(color: Color(0xFF2CBB66), fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    // List
                    GetX<TeacherGetxController>(
                      builder: (controller){
                        return Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'images/calendar_icon.svg',
                                          color: Colors.black,
                                          width: 20.w,
                                          height: 20.h,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(controller.allRecordList[index].day),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: isRecordColor(controller.allRecordList, index),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        //margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: isRecordColor2(controller.allRecordList, index),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 15,
                                              bottom: 15),
                                          child: controller.allRecordList[index].isDailyRecord ? ListView.separated(
                                            itemBuilder: (context, index1) {
                                              return Row(
                                                children: [
                                                  Text(
                                                    getType(controller.allRecordList[index].dailyRecord![index1].typeId) + ": " + getSurah(int.parse(controller.allRecordList[index].dailyRecord![index1].fromSura.toString()), surahList).name + " " + controller.allRecordList[index].dailyRecord![index1].fromAya.toString() + " - " + getSurah(int.parse(controller.allRecordList[index].dailyRecord![index1].toSura.toString()), surahList).name + " " + controller.allRecordList[index].dailyRecord![index1].toAya.toString(),
                                                    style: TextStyle(
                                                        color: Color(0xFF103E1C),
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 16.sp),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '5',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFF39C12),
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        SvgPicture.asset(
                                                          'images/stare_icon.svg',
                                                          width: 13.w,
                                                          height: 13.h,
                                                        ),
                                                      ],
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                  ),
                                                ],
                                              );
                                            }, shrinkWrap: true, itemCount: controller.allRecordList[index].dailyRecord!.length, physics: NeverScrollableScrollPhysics(),separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10.h,); },) : Text(isRecord(controller.allRecordList, index), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.allRecordList.length,
                          ),
                        );
                      },
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
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfileScreen2()));},
                    child: GetBuilder<TeacherGetxController>(
                      builder: (context){
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
                  subtitle: GetBuilder<TeacherGetxController>(
                    builder: (context){
                      return Text(_teacherGetxController.userLogin.first_name + " " + _teacherGetxController.userLogin.last_name,
                          style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold));
                    },
                  ),
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
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolDataScreen(school: school)));},
                child: GetBuilder<TeacherGetxController>(
                  builder: (context){
                    return CircleAvatar(
                      backgroundImage: NetworkImage("https://kuttab.sirius-it.dev/" +
                          _teacherGetxController.school.logo),
                      radius: 55,
                    );
                  },
                ),
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

  School get school{
    School school = School();
    school.name = _teacherGetxController.school.name;
    school.logo = _teacherGetxController.school.logo;
    school.address = _teacherGetxController.school.address;
    school.description = _teacherGetxController.school.description;
    return school;
  }

  String isRecord(List<DailyRecord2> list, int index){
    if(list[index].isRecord){
      if(list[index].isAttended){
        if(list[index].isDailyRecord){
          return list[index].dailyRecord![index].typeId.toString() + ": " + list[index].dailyRecord![index].fromSura.toString() + " " + list[index].dailyRecord![index].fromAya.toString() + " - " + list[index].dailyRecord![index].toSura.toString() + " " + list[index].dailyRecord![index].toAya.toString();
        }else{
          return 'لم يسمع';
        }
      }else{
        return 'غائب';
      }
    }else{
      return 'لم يسجل';
    }
  }

  Color isRecordColor(List<DailyRecord2> list, int index){
    if(list[index].isRecord){
      if(list[index].isAttended){
        if(list[index].isDailyRecord){
          return Colors.green;
        }else{
          return Colors.yellow;
        }
      }else{
        return Colors.red;
      }
    }else{
      return Colors.grey;
    }
  }

  Color isRecordColor2(List<DailyRecord2> list, int index){
    if(list[index].isRecord){
      if(list[index].isAttended){
        if(list[index].isDailyRecord){
          return Color(0x77FFFFFF);
        }else{
          return Color(0x77FFFFFF);
        }
      }else{
        return Color(0x77FFFFFF);
      }
    }else{
      return Color(0x77FFFFFF);
    }
  }

  String getType(int typeID){
    return typeID == 1 ? 'حفظ' : typeID == 3 ? "تلاوة" : typeID == 2 ? "مراجعة" : '';
  }

  Surah getSurah(int number, List<dynamic> list){
    Surah? result;
    for(Surah surah in list){
      if(surah.number == number){
        result = surah;
        break;
      }
    }
    return result!;
  }

}
