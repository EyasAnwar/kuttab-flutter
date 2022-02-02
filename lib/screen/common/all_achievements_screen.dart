import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:quran/getx_controller/teacher_getx_controller.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/daily_record.dart';
import 'package:quran/models/surah.dart';

class ALLAchievementsScreen extends StatefulWidget {
  late int id;
  late List<dynamic> surahList;

  ALLAchievementsScreen({required this.id, required this.surahList});

  @override
  _ALLAchievementsScreenState createState() => _ALLAchievementsScreenState();
}

class _ALLAchievementsScreenState extends State<ALLAchievementsScreen> {
  TeacherGetxController _teacherGetxController = Get.put(TeacherGetxController());
  bool hide = false;
  DateTime toDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  DateTime fromDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days:7))));

  void initState() {
    super.initState();
    _teacherGetxController.getSingleStudentAchievement(from: DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days:7))).toString(), to: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(), id: widget.id);
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
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              toDate = fromDate;
                              fromDate = toDate.subtract(Duration(days:7));
                              hide = true;
                            });
                            _teacherGetxController.getSingleStudentAchievement(from: DateFormat('yyyy-MM-dd').format(fromDate), to: DateFormat('yyyy-MM-dd').format(toDate).toString(), id: widget.id);
                          },
                          child: SvgPicture.asset(
                            'images/back_icon.svg',
                            color: Colors.black,
                            width: 18,
                            height: 18,
                          ),
                        ),
                        Spacer(),
                        Text(DateFormat('dd-MM-yyyy').format(fromDate) + "  -  " + DateFormat('dd-MM-yyyy').format(toDate), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),),
                        Spacer(),
                        Visibility(
                          visible: hide,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                if(DateFormat('yyyy-MM-dd').format(toDate) != DateFormat('yyyy-MM-dd').format(DateTime.now())){
                                  fromDate = toDate;
                                  toDate = fromDate.add(Duration(days: 7));
                                }else{
                                  hide = false;
                                }
                              });
                              _teacherGetxController.getSingleStudentAchievement(from: DateFormat('yyyy-MM-dd').format(fromDate), to: DateFormat('yyyy-MM-dd').format(toDate).toString(), id: widget.id);
                            },
                            child: SvgPicture.asset(
                              'images/forword_icon.svg',
                              color: Colors.black,
                              width: 18.w,
                              height: 18.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GetX<TeacherGetxController>(
                        builder: (controller){
                          return ListView.builder(
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
                                        Text(controller.dailyRecordList[index].day),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: isRecordColor(controller.dailyRecordList, index),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        //margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: isRecordColor2(controller.dailyRecordList, index),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 15,
                                              bottom: 15),
                                          child: controller.dailyRecordList[index].isDailyRecord ? ListView.separated(
                                            itemBuilder: (context, index1) {
                                              return Row(
                                                children: [
                                                  Text(
                                                    getType(controller.dailyRecordList[index].dailyRecord![index1].typeId) + ": " + getSurah(int.parse(controller.dailyRecordList[index].dailyRecord![index1].fromSura.toString()), widget.surahList).name + " " + controller.dailyRecordList[index].dailyRecord![index1].fromAya.toString() + " - " + getSurah(int.parse(controller.dailyRecordList[index].dailyRecord![index1].toSura.toString()), widget.surahList).name + " " + controller.dailyRecordList[index].dailyRecord![index1].toAya.toString(),
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
                                                          width: 5,
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
                                            }, shrinkWrap: true, itemCount: controller.dailyRecordList[index].dailyRecord!.length, physics: NeverScrollableScrollPhysics(),separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10.h,); },) : Text(isRecord(controller.dailyRecordList, index), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.dailyRecordList.length,
                          );
                        },
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
                    "كل الانجازات",
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
