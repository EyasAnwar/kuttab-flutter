import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:quran/getx_controller/login_getx_controller.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/attendance.dart';
import 'package:quran/models/daily_record.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/models/user.dart';
import 'package:quran/screen/common/all_achievements_screen.dart';
import 'package:quran/screen/common/edit_student_profile.dart';
import 'package:quran/widgets/app_text_field.dart';

class StudentProfileScreen3 extends StatefulWidget {
  late int id;

  StudentProfileScreen3({required this.id});

  @override
  _StudentProfileScreen3State createState() => _StudentProfileScreen3State();
}

class _StudentProfileScreen3State extends State<StudentProfileScreen3> {
  TeacherGetxController _teacherGetxController =
      Get.put(TeacherGetxController());
  late TextEditingController _reasonController;
  String? dropdownValue;
  List<dynamic> surahList = [];
  final surahStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
    _teacherGetxController.getStudent(id: widget.id);
    _teacherGetxController.getResone();
    _teacherGetxController.getAllSingleStudentAchievement(from: DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days:2))).toString(), to: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(), id: widget.id);
    var result = surahStorage.read('surahList');
    dynamic jsonData = jsonDecode(result);
    surahList = jsonData.map((surah) => Surah.fromJson(surah)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Color(0xFF6AC891),
              child: Image.asset('images/app_header.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      ListTile(
                        leading: GetBuilder<TeacherGetxController>(
                          builder: (context) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://kuttab.sirius-it.dev/storage/" +
                                      _teacherGetxController
                                          .selectedUser.image),
                              radius: 30,
                            );
                          },
                        ),
                        horizontalTitleGap: 15,
                        title: GetBuilder<TeacherGetxController>(
                          builder: (context) {
                            return Text(
                              _teacherGetxController.selectedUser.first_name +
                                  " " +
                                  _teacherGetxController
                                      .selectedUser.middle_name +
                                  " " +
                                  _teacherGetxController.selectedUser.last_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.sp),
                            );
                          },
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditStudentProfile(user: user)));
                          },
                          child: Text(
                            'تعديل الحساب',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      // SizedBox(height: 25),
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
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        onPressed: () {
                          showAbsenceDialog(context, _reasonController);
                        },
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
                              width: 20.w,
                            ),
                            Text(
                              'اذن غياب',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: Colors.green),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                color: Color(0xFF2CBC67),
                              )),
                        ),
                      ),
                      // SizedBox(height: 30,),
                      // // teacher info header
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
                      SizedBox(height: 25.h),
                      Row(
                        children: [
                          Text(
                            "احدث الانجازات",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.sp),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ALLAchievementsScreen(id: widget.id, surahList: surahList,)));},
                            child: Text(
                              "عرض الكل",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16.sp),
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
                      GetX<TeacherGetxController>(
                        builder: (controller){
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                          );
                        },
                      ),
                      SizedBox(height: 15.h),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'المدة',
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold, fontSize: 17),
                      //     ),
                      //     Spacer(),
                      //     ElevatedButton(
                      //       onPressed: () {},
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             '13/12/2001',
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           SvgPicture.asset(
                      //             'images/calendar2_icon.svg',
                      //             color: Colors.green,
                      //             width: 20,
                      //             height: 20,
                      //           ),
                      //         ],
                      //       ),
                      //       style: ElevatedButton.styleFrom(
                      //         minimumSize: const Size(100, 50),
                      //         primary: Colors.white,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(30),
                      //             side:
                      //             BorderSide(color: Colors.grey, width: 1)),
                      //       ),
                      //     ),
                      //     Text('    -    '),
                      //     ElevatedButton(
                      //       onPressed: () {},
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             '13/12/2001',
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           SvgPicture.asset(
                      //             'images/calendar2_icon.svg',
                      //             color: Colors.green,
                      //             width: 20,
                      //             height: 20,
                      //           ),
                      //         ],
                      //       ),
                      //       style: ElevatedButton.styleFrom(
                      //         minimumSize: const Size(100, 50),
                      //         primary: Colors.white,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(30),
                      //             side:
                      //             BorderSide(color: Colors.grey, width: 1)),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Container(
                      //   width: double.infinity,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     border:
                      //     Border.all(width: 1, color: Color(0xFFE4E6EA)),
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
                      //                 "الحفط",
                      //                 style: TextStyle(fontSize: 16.sp),
                      //               ),
                      //             ),
                      //             Divider(indent: 1),
                      //             Text(
                      //               "المراجعة",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(indent: 1),
                      //             Text(
                      //               "التلاوة",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(indent: 1),
                      //             Text(
                      //               "ايام الحضور",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(indent: 1),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 8.0),
                      //               child: Text(
                      //                 "ايام الغياب",
                      //                 style: TextStyle(fontSize: 16.sp),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding:
                      //         const EdgeInsets.only(right: 30, top: 12),
                      //         child: Column(
                      //           children: [
                      //             Text(
                      //               "الحاقة 15 - الحاقة 20",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(
                      //               indent: 1,
                      //               color: Color(0xFF000000),
                      //             ),
                      //             Text(
                      //               "الحاقة 15 - الحاقة 20",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(
                      //               indent: 1,
                      //               color: Color(0xFF000000),
                      //             ),
                      //             Text(
                      //               "الحاقة 15 - الحاقة 20",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(
                      //               indent: 1,
                      //               color: Color(0xFF000000),
                      //             ),
                      //             Text(
                      //               "3 ايام",
                      //               style: TextStyle(fontSize: 16.sp),
                      //             ),
                      //             Divider(indent: 1, color: Color(0xFF00000)),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 8.0),
                      //               child: Text(
                      //                 "7 ايام",
                      //                 style: TextStyle(fontSize: 16.sp),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
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
                      height: 120.h,
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'images/back_icon.svg',
                        color: Color(0xFFFFFFFF),
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    SizedBox(
                      width: 110.w,
                    ),
                    Center(
                        child: Text(
                      "حساب الطالب",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Colors.white),
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  User get user {
    User user = User();
    user.first_name = _teacherGetxController.selectedUser.first_name;
    user.middle_name = _teacherGetxController.selectedUser.middle_name;
    user.last_name = _teacherGetxController.selectedUser.last_name;
    user.birth_date = _teacherGetxController.selectedUser.birth_date;
    user.academic = _teacherGetxController.selectedUser.academic;
    user.mobile_number = _teacherGetxController.selectedUser.mobile_number;
    user.address = _teacherGetxController.selectedUser.address;
    user.id = _teacherGetxController.selectedUser.id;
    user.image = _teacherGetxController.selectedUser.image;
    return user;
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

  void showAbsenceDialog(BuildContext context, var _reasonController) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context,StateSetter setState) {
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
                          onTap: (){Navigator.pop(context);},
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
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        SizedBox(width: 20.w,)
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
                          value: dropdownValue ?? _teacherGetxController.reasonsList2[0],
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
                    SizedBox(height: 20.h,),
                    AppTextFiled(
                        controller: _reasonController,
                        hint: "ادخل سبب الغياب",
                        icon: "images/note_icon.svg",
                        textFiledTitle: "سبب الغياب"),
                    SizedBox(
                      height: 40.h,
                    ),
                    ElevatedButton(
                      onPressed: () {Navigator.pop(context); TeacherGetxController.to.setAttendance(context, Attendance(isAttended: false, date: DateTime.now().toString(), reason: _reasonController.text, userId: SharedPreferencesController().user!.id.toString()));},
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
            }
        );
      },
    );
  }
}
