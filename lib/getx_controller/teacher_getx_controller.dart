import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quran/api/api_controller/auth.dart';
import 'package:quran/api/api_controller/teacher.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/achievement.dart';
import 'package:quran/models/attendance.dart';
import 'package:quran/models/class.dart';
import 'package:quran/models/dailyRecord.dart';
import 'package:quran/models/daily_record.dart';
import 'package:quran/models/login.dart';
import 'package:quran/models/resone.dart';
import 'package:quran/models/school.dart';
import 'package:quran/models/user.dart';
import 'package:quran/screen/common/login_screen.dart';
import 'package:quran/screen/teacher/teacher_profile_screen.dart';
import 'package:quran/utils/helper.dart';
import 'package:quran/widgets/bottom_sheet.dart';

class TeacherGetxController extends GetxController with Helper {
  RxList<User> userList = <User>[].obs;
  RxList<Achievement> childrenList = <Achievement>[].obs;
  RxList<User> searchUser = <User>[].obs;
  RxList<AttendanceReasons> reasonsList = <AttendanceReasons>[].obs;
  RxList<String> reasonsList2 = <String>['غير محدد'].obs;
  RxList<Achievement> achievementList = <Achievement>[].obs;
  RxList<DailyRecord2> dailyRecordList = <DailyRecord2>[].obs;
  RxList<DailyRecord2> allRecordList = <DailyRecord2>[].obs;
  RxList<DailyRecord> dailyRecordLimitedList = <DailyRecord>[].obs;
  School school = School();
  User userLogin = User();
  User selectedUser = User();
  TeacherApiController _teacherGetxController = TeacherApiController();

  static TeacherGetxController get to => Get.find();

  @override
  void onInit() {
    getStudentAchievement(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        lastRecord: 'quraan');
    super.onInit();
  }

  Future<void> getTeacherStudent() async {
    userList.value = await _teacherGetxController.getTeacherStudent();
    update();
  }

  Future<void> getParentChildren(String date) async {
    childrenList.value =
        await _teacherGetxController.getChildrenAchievement(date: date);
    update();
  }

  Future<void> getSchool() async {
    school = await _teacherGetxController.getSchool();
    if (school != null) {
      print('Get School Successfully');
      SharedPreferencesController().saveSchoolData(school: school);
    }
    update();
  }

  Future<void> getUserLogin() async {
    userLogin = await _teacherGetxController.getUserLogin();
    update();
  }

  Future<void> getStudent({required int id}) async {
    selectedUser = await _teacherGetxController.getStudent(id: id);
    update();
  }

  Future<void> updateTeacher(
      {required BuildContext context, required User user}) async {
    bool state = await _teacherGetxController.updateTeacher(user: user);
    if (user.first_name.isNotEmpty &&
        user.address.isNotEmpty &&
        user.mobile_number.toString().isNotEmpty &&
        user.last_name.isNotEmpty &&
        user.birth_date.isNotEmpty &&
        user.academic.isNotEmpty) {
      if (state) {
        print('updated');
        getUserLogin();
        Navigator.pop(context);
      } else {
        Helper.showSnackBar(context, text: 'حدث خطا ما', error: true);
      }
    } else {
      Helper.showSnackBar(context, text: 'ادخل البيانات المطلوبة', error: true);
    }
  }

  Future<void> updateStudent(
      {required BuildContext context, required User user}) async {
    bool state = await _teacherGetxController.updateStudent(user: user);
    if (user.first_name.isNotEmpty &&
        user.address.isNotEmpty &&
        user.mobile_number.toString().isNotEmpty &&
        user.last_name.isNotEmpty &&
        user.birth_date.isNotEmpty &&
        user.academic.isNotEmpty) {
      if (state) {
        print('updated');
        getStudent(id: user.id);
        Navigator.pop(context);
      } else {
        Helper.showSnackBar(context, text: 'حدث خطا ما', error: true);
      }
    } else {
      Helper.showSnackBar(context, text: 'ادخل البيانات المطلوبة', error: true);
    }
  }

  Future<void> setAttendance(
      BuildContext context, Attendance attendance) async {
    if (attendance.reason.isNotEmpty) {
      bool state =
          await _teacherGetxController.setAttendance(attendance: attendance);
      if (state) {
        if (attendance.isAttended) {
          BottomSheets().showThanksDialog(context, 'حضورك');
        } else {
          BottomSheets().showThanksDialog(context, 'غيابك');
        }
      } else {
        Helper.showSnackBar(context, text: 'حدث خطا ما', error: true);
      }
    } else {
      Helper.showSnackBar(context, text: 'ادخل سبب الغياب', error: true);
    }
  }

  Future<void> setMAttendance(BuildContext context, {String? resone}) async {
    List<Attendance> attendances = [];
    if (resone != null && resone != 'غير محدد' && resone.isNotEmpty) {
      childrenList.value.forEach((element) {
        attendances.add(Attendance(
            isAttended: false,
            date: DateTime.now().toString(),
            reason: resone,
            userId: element.id.toString()));
      });
    } else {
      achievementList.value.forEach((element) {
        attendances.add(Attendance(
            isAttended: element.isAttendance,
            date: DateTime.now().toString(),
            reason: "من المحفظ",
            userId: element.id.toString()));
      });
    }
    bool state =
        await _teacherGetxController.setMAttendance(attendances: attendances);
    if (state) {
      Navigator.pop(context);
    } else {
      Helper.showSnackBar(context, text: 'حدث خطا ما', error: true);
    }
  }

  Future<void> searchStudent(
      {required BuildContext context, required String username}) async {
    if (username.isNotEmpty) {
      userList.clear();
      userList.value
          .add(await _teacherGetxController.searchStudent(username: username));
      print('added');
    } else {
      getTeacherStudent();
    }
  }

  Future<void> getStudentAchievement(
      {required String date, required String lastRecord}) async {
    achievementList.value = await _teacherGetxController.getStudentAchievement(
        date: date, lastRecord: lastRecord);
    update();
  }

  Future<void> getSingleStudentAchievement(
      {required String from, required String to, required int id}) async {
    dailyRecordList.value = await _teacherGetxController
        .getSingleStudentAchievement(from: from, to: to, id: id);
  }

  Future<void> getAllSingleStudentAchievement(
      {required String from, required String to, required int id}) async {
    allRecordList.value = await _teacherGetxController
        .getSingleStudentAchievement(from: from, to: to, id: id);
  }

  // Future<void> getSingleStudentAchievement2({required String limit, required int id}) async {
  //   dailyRecordLimitedList.value = await _teacherGetxController.getSingleStudentAchievement2(limit: limit, id: id);
  // }

  Future<void> setDailyRecord(
      {required BuildContext context, required DailyRecord dailyRecord}) async {
    if (dailyRecord.quraan.toAya.isNotEmpty &&
        dailyRecord.quraan.fromSura.isNotEmpty &&
        dailyRecord.quraan.toSura.isNotEmpty &&
        dailyRecord.quraan.fromAya.isNotEmpty) {
      bool state =
          await _teacherGetxController.setDailyRecord(dailyRecord: dailyRecord);
      if (state) {
        Navigator.pop(context);
        Helper.showSnackBar(context, text: "تم اضافة انجاز بنجاح");
      }
    }
  }

  Future<void> getResone() async {
    reasonsList.value = await _teacherGetxController.getResone();
    for (AttendanceReasons reson in reasonsList) {
      reasonsList2.value.add(reson.title);
    }
  }
}
