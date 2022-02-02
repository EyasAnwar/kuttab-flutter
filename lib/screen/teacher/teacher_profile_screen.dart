import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:quran/getx_controller/login_getx_controller.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/user.dart';
import 'package:quran/screen/common/about_screen.dart';

import 'edit_profile_screen.dart';
import '../common/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TeacherGetxController _teacherGetxController = Get.put(TeacherGetxController());
  LoginGetxController _loginGetxController = Get.put(LoginGetxController());

  @override
  void initState() {
    super.initState();
    _loginGetxController;
    _teacherGetxController.getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF6AC891),
            child: Image.asset('images/app_header.png')
          ),
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
                    SizedBox(height: 50.h),
                    Text(
                      _teacherGetxController.userLogin.first_name + " " +  _teacherGetxController.userLogin.middle_name + " " + _teacherGetxController.userLogin.last_name,
                      style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _teacherGetxController.userLogin.type,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: 40.h,),
                    // teacher info header
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Text("بيانات الحلقة",
                    //       style: TextStyle(
                    //           fontSize: 16, fontWeight: FontWeight.bold)),
                    // ),
                    // SizedBox(height: 5,),
                    // teacher info
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
                            width: 1.w, color: Color(0xFFE4E6EA)),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)));},
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
                                    height: 20.w,
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
                    SizedBox(height: 40),
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
                  Spacer(),
                  Text(
                    "حسابي",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: Colors.white),
                  ),
                  Spacer(),
                  SizedBox(width: 20.w,)
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
    return user;
  }

}
