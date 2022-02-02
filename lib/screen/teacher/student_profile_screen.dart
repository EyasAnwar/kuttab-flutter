import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/achievementRecord.dart';
import 'package:quran/models/attendance.dart';
import 'package:quran/models/dailyRecord.dart';
import 'package:quran/models/daily_record.dart';
import 'package:quran/models/surah.dart';
import 'package:quran/models/user.dart';
import 'package:quran/screen/common/edit_student_profile.dart';
import 'package:quran/screen/common/launch_screen.dart';
import 'package:quran/widgets/app_text_field.dart';

import '../common/all_achievements_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  late int id;
  late int school_id;
  late bool isAttendance;

  StudentProfileScreen({required this.id, required this.school_id, required this.isAttendance});

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  TeacherGetxController _teacherGetxController = Get.put(TeacherGetxController());
  late TextEditingController _fromAya;
  late TextEditingController _toAya;
  String? dropdownValue;
  bool isFrom = true;
  RxString fromSurah= '1'.obs;
  RxString toSurah= '1'.obs;
  List<dynamic> surahList = [];
  int rate = 0;
  final surahStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    _fromAya = TextEditingController();
    _toAya = TextEditingController();
    _teacherGetxController.getStudent(id: widget.id);
    _teacherGetxController.getAllSingleStudentAchievement(from: DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days:2))).toString(), to: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(), id: widget.id);
    var result = surahStorage.read('surahList');
    dynamic jsonData = jsonDecode(result);
    surahList = jsonData.map((surah) => Surah.fromJson(surah)).toList();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fromAya.dispose();
    _toAya.dispose();
    _teacherGetxController.getStudentAchievement(date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(), lastRecord: 'quraan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                color: Color(0xFF6AC891),
                child: Image.asset('images/app_header.png')),
            Padding(
              padding: const EdgeInsets.only(top: 100),
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
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      ListTile(
                        leading: GetBuilder<TeacherGetxController>(
                          builder: (context) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://kuttab.sirius-it.dev/storage/" + _teacherGetxController.selectedUser.image),
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
                      SizedBox(height: 25.h),
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
                      // SizedBox(height: 40),
                      widget.isAttendance ? ElevatedButton(
                        onPressed: () {
                          showRecordDialog();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/achievement_icon.svg',
                              color: Colors.white,
                              width: 20.w,
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'تسجيل انجاز جديد',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 53),
                          primary: const Color(0xFF2CBC67),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ):
                      ElevatedButton(
                        onPressed: () {
                          TeacherGetxController.to.setAttendance(context, Attendance(isAttended: true, date: DateTime.now().toString(), reason: 'No reason', userId: widget.id.toString()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/achievement_icon.svg',
                              color: Colors.white,
                              width: 20.w,
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'تسجيل حضور',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 53),
                          primary: const Color(0xFF2CBC67),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ALLAchievementsScreen(id: widget.id, surahList: surahList,)));
                            },
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
                          _teacherGetxController.getAllSingleStudentAchievement(from: DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days:2))).toString(), to: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(), id: widget.id);
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
                      // SizedBox(height: 30),
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
                      //                 BorderSide(color: Colors.grey, width: 1)),
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
                      //                 BorderSide(color: Colors.grey, width: 1)),
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
                      //         Border.all(width: 1, color: Color(0xFFE4E6EA)),
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
                      //             const EdgeInsets.only(right: 30, top: 12),
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

  void showRecordDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (
            BuildContext context,StateSetter setState ,) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xff8A8A8E).withOpacity(0.5),
                        child: SvgPicture.asset(
                          'images/cancel_icon.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'تسجيل انجاز جديد',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    SizedBox(width: 20.w)
                  ],
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
                      'نوع الانجاز',
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
                      value: dropdownValue ?? 'حفط',
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
                      items: <String>['حفط', 'مراجعة', 'تلاوة']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'من',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        showSurahDialog();
                        isFrom = true;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 1.w, color: Colors.green),
                        ),
                        width: 80.w,
                        height: 50.h,
                        child: Obx(
                              () =>
                              Center(
                                child: Text(
                                  getSurah(int.parse(fromSurah.value), surahList).name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                        width: 50.w,
                        height: 50.h,
                        child: SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _fromAya,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFE4E6EA),
                                  width: 1.w,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xff2CBC67),
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(width: 15.w),
                    Text(
                      'الى',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        showSurahDialog();
                        isFrom = false;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 1.w, color: Colors.green),
                        ),
                        width: 80.w,
                        height: 50.h,
                        child: Center(
                          child: Obx(
                                () =>
                                Center(
                                  child: Text(
                                    getSurah(int.parse(toSurah.value), surahList).name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                        width: 50.w,
                        height: 50.h,
                        child: SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _toAya,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFE4E6EA),
                                  width: 1.w,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xff2CBC67),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'images/star2_icon.svg',
                      color: Colors.green,
                      width: 20.w,
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      'التقييم',
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
                  child: Center(
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (rating) {
                        rate = rating.round();
                      },
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1.w, color: Color(0xFFE4E6EA)),
                  ),
                  width: double.infinity,
                  height: 60.h,
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: () {
                    TeacherGetxController.to.setDailyRecord(
                        context: context, dailyRecord: dailyRecord);
                  },
                  child: Text(
                    'تسجيل الانجاز',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 53),
                    primary: Color(0xFF2CBC67),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        });
      },
    );
  }

  void showSurahDialog() {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xff8A8A8E),
                    child: SvgPicture.asset(
                      'images/cancel_icon.svg',
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'السوره',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  SizedBox(width: 20.w),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1.w, color: Color(0xFFE4E6EA)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    GestureDetector(
                      onTap: () {},
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
                      height: 53.h,
                      child: TextField(
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
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            if(isFrom){
                              fromSurah.value = surahList[index].number.toString();
                            }else{
                              toSurah.value = surahList[index].number.toString();
                            }
                          });
                          Navigator.pop(context);
                        },
                        title: Text(surahList[index].name),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Color(0xffE4E6EA),
                      );
                    },
                    itemCount: surahList.length),
              )
            ],
          ),
        );
      },
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

  DailyRecord get dailyRecord{
    DailyRecord dailyRecord = DailyRecord();
    dailyRecord.score = rate;
    dailyRecord.review = rate == 5 ? 'ممتاز' : rate == 4 ? "جيد جدا" : rate == 3 ? "جيد" : rate == 2 ? "سيئ" : rate == 1 ? "سيء جدا" : "";
    dailyRecord.date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    dailyRecord.studentId = widget.id;
    dailyRecord.schoolId = widget.school_id;
    dailyRecord.teacherId = SharedPreferencesController().user!.id;
    dailyRecord.type = 'quraan';
    dailyRecord.quraan = Quraan(typeId: dropdownValue == 'حفظ' ? 1 : dropdownValue == 'تلاوة' ? 2 : dropdownValue == 'مراجعة' ? 3 : 0, fromAya: _fromAya.text, toAya: _toAya.text, fromSura: fromSurah.value, toSura: toSurah.value);
    return dailyRecord;
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
