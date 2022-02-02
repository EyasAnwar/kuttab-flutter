import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:quran/getx_controller/login_getx_controller.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/user.dart';

import '../common/about_screen.dart';
import '../common/edit_student_profile.dart';
import '../teacher/edit_profile_screen.dart';
import '../common/setting_screen.dart';

class StudentProfileScreen2 extends StatefulWidget {
  const StudentProfileScreen2({Key? key}) : super(key: key);

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen2> {
  LoginGetxController _logoutGetsController = Get.put(LoginGetxController());
  TeacherGetxController _teacherGetxController = Get.put(TeacherGetxController());

  @override
  void initState() {
    super.initState();
    _logoutGetsController;
    _teacherGetxController.getUserLogin();
    _teacherGetxController.getTeacherStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                color: Color(0xFF6AC891),
                child: Image.asset('images/app_header.png')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Container(
                width: double.infinity,
                height: 770.h,
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
                      SizedBox(height: 50.h),
                      GetBuilder<TeacherGetxController>(
                        builder: (context){
                          return Text(
                            _teacherGetxController.userLogin.first_name + " " + _teacherGetxController.userLogin.middle_name + " " + _teacherGetxController.userLogin.last_name,
                            style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      GetBuilder<TeacherGetxController>(
                        builder: (context){
                          return Text(
                            _teacherGetxController.userLogin.type,
                            style: TextStyle(fontSize: 18.sp),
                          );
                        },
                      ),
                      SizedBox(height: 40.h,),
                      // Row(
                      //   children: [
                      //     Spacer(),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           'الحفظ',
                      //           style: TextStyle(
                      //               fontSize: 17, color: Color(0xFF103E1C)),
                      //         ),
                      //         Text(
                      //           '50',
                      //           style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.bold,
                      //               color: Color(0xFF103E1C)),
                      //         ),
                      //         Text(
                      //           'صفحة',
                      //           style: TextStyle(
                      //               fontSize: 15, color: Color(0xFF80103E1C)),
                      //         ),
                      //       ],
                      //     ),
                      //     Spacer(),
                      //     Spacer(),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           'المراجعة',
                      //           style: TextStyle(
                      //               fontSize: 17, color: Color(0xFF103E1C)),
                      //         ),
                      //         Text(
                      //           '20',
                      //           style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.bold,
                      //               color: Color(0xFF103E1C)),
                      //         ),
                      //         Text(
                      //           'صفحة',
                      //           style: TextStyle(
                      //               fontSize: 15, color: Color(0xFF80103E1C)),
                      //         ),
                      //       ],
                      //     ),
                      //     Spacer(),
                      //     Spacer(),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           'التلاوة',
                      //           style: TextStyle(
                      //               fontSize: 17, color: Color(0xFF103E1C)),
                      //         ),
                      //         Text(
                      //           '13',
                      //           style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.bold,
                      //               color: Color(0xFF103E1C)),
                      //         ),
                      //         Text(
                      //           'صفحة',
                      //           style: TextStyle(
                      //               fontSize: 15, color: Color(0xFF80103E1C)),
                      //         ),
                      //       ],
                      //     ),
                      //     Spacer(),
                      //   ],
                      // ),
                      // SizedBox(height: 40,),
                      // teacher info header
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Text("بيانات الحلقة",
                      //       style: TextStyle(
                      //           fontSize: 16, fontWeight: FontWeight.bold)),
                      // ),
                      // SizedBox(height: 5,),
                      // // teacher info
                      // Container(
                      //   width: double.infinity,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(width: 1, color: Color(0xFFE4E6EA)),
                      //     borderRadius: BorderRadius.circular(30),
                      //     color: Colors.white,
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 150,
                      //         decoration: BoxDecoration(
                      //           border: Border.all(
                      //               width: 1, color: Color(0xFFE4E6EA)),
                      //           borderRadius: BorderRadius.circular(20),
                      //           color: Color(0xFFF4F4F4),
                      //         ),
                      //         child: Column(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 8.0),
                      //               child: Text(
                      //                 "اسم الحلقة",
                      //                 style: TextStyle(fontSize: 16.sp),
                      //               ),
                      //             ),
                      //             Divider(indent: 1),
                      //             Text(
                      //               "مساعد المحفظ",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(indent: 1),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 8.0),
                      //               child: Text(
                      //                 "عدد الطلاب",
                      //                 style: TextStyle(fontSize: 16.sp),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 208,
                      //         child: Column(
                      //           children: [
                      //             Text(
                      //               "اسم الحلقة",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(indent: 1),
                      //             Text(
                      //               "مساعد المحفظ",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(indent: 1),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 8.0),
                      //               child: Text(
                      //                 "${_teacherGetxController.userList.length}",
                      //                 style: TextStyle(fontSize: 16.sp),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 40),
                      // Setting
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Color(0xFFE4E6EA)),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditStudentProfile(user: user)));},
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/personal_icon.svg',
                                      color: Colors.green,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text('المعلومات الشخصية', style: TextStyle(fontSize: 17.sp, color: Color(0xFF2CBC67)), ),
                                    Spacer(),
                                    SvgPicture.asset(
                                      'images/forword_icon.svg',
                                      color: Colors.green,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(indent: 1),
                              GestureDetector(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));},
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/setting_icon.svg',
                                      color: Colors.green,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text('الاعدادات', style: TextStyle(fontSize: 17.sp, color: Color(0xFF2CBC67)), ),
                                    Spacer(),
                                    SvgPicture.asset(
                                      'images/forword_icon.svg',
                                      color: Colors.green,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(indent: 1),
                              GestureDetector(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));},
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/about_icon.svg',
                                      color: Colors.green,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text('حول التطبيق', style: TextStyle(fontSize: 17.sp, color: Color(0xFF2CBC67)), ),
                                    Spacer(),
                                    SvgPicture.asset(
                                      'images/forword_icon.svg',
                                      color: Colors.green,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: (){LoginGetxController.to.logout(context);},
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/logout_icon.svg',
                              color: Color(0xFFE64C3C),
                              width: 20.w,
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(' تسجيل الخروج', style: TextStyle(fontSize: 17.sp, color: Color(0xFFE64C3C)), ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 100.h,
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
                    SizedBox(
                      width: 135.w,
                    ),
                    Center(
                        child: Text(
                          "حسابي",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: Colors.white),
                        )),
                  ],
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage("https://kuttab.sirius-it.dev/storage/" + _teacherGetxController.userLogin.image),
                  radius: 55,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  User get user{
    User user = User();
    user.first_name = _teacherGetxController.userLogin.first_name;
    user.middle_name = _teacherGetxController.userLogin.middle_name;
    user.last_name = _teacherGetxController.userLogin.last_name;
    user.birth_date = _teacherGetxController.userLogin.birth_date;
    user.academic = _teacherGetxController.userLogin.academic;
    user.mobile_number = _teacherGetxController.userLogin.mobile_number;
    user.address = _teacherGetxController.userLogin.address;
    user.id = _teacherGetxController.userLogin.id;
    user.image = _teacherGetxController.userLogin.image;
    return user;
  }

}
