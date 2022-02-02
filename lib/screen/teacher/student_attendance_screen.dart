import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:quran/getx_controller/login_getx_controller.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/attendance.dart';

class StudentAttendanceScreen extends StatefulWidget {
  late List<bool> isAttendance;

  StudentAttendanceScreen({required this.isAttendance});

  @override
  _StudentAttendanceScreenState createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  TeacherGetxController _teacherGetxController = Get.put(TeacherGetxController());
  List<Attendance> users = <Attendance>[];

  @override
  void initState() {
    // TODO: implement initState
    _teacherGetxController.getStudentAchievement(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        lastRecord: 'quraan');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _teacherGetxController.getStudentAchievement(date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(), lastRecord: 'quraan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: Color(0xFF6AC891),
              child: Image.asset('images/app_header.png')),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 20, left: 20),
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, right: 90),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'ارسال تنبيه للغائبين',
                                style: TextStyle(
                                  color: Color(0xff2CBC67),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: GetX<TeacherGetxController>(
                      builder: (TeacherGetxController controller) {
                        if (controller.achievementList.isNotEmpty) {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                // controller.userList[index].isAttendance = widget.isAttendance[index];
                                return ListTile(
                                  leading: CircleAvatar(backgroundImage: NetworkImage("https://kuttab.sirius-it.dev/storage/" + controller.achievementList[index].image), radius: 30,),
                                  horizontalTitleGap: 15,
                                  title: Text(controller.achievementList[index].firstName + " " + controller.achievementList[index].middleName + " " + controller.achievementList[index].lastName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
                                  trailing: Checkbox(
                                    checkColor: Color(0xFFFFFFFF),
                                    activeColor: Color(0xFF2CBC67),
                                    onChanged: (bool? valuee) {
                                      setState(() {
                                        controller.achievementList[index].isAttendance = valuee!;
                                      });
                                    },
                                    value: controller.achievementList[index].isAttendance,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Color(0xFFE4E6EA),
                                  thickness: 1,
                                  indent: 1,
                                );
                              },
                              itemCount: controller.achievementList.length);
                        }else{
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          TeacherGetxController.to.setMAttendance(context);
                        },
                        child: Text(
                          'حفظ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 53),
                          primary: Color(0xff2CBC67),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 120.h,
                    width: 20.w,
                  ),
                  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: SvgPicture.asset(
                      'images/back_icon.svg',
                      color: Color(0xFFFFFFFF),
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "حضور الطلاب",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.white),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 30.w,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
