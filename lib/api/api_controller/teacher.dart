import 'dart:convert';
import 'dart:io';

import 'package:quran/api/helper/api_mixin.dart';
import 'package:quran/local_storge/shared_preferences/preferences.dart';
import 'package:quran/models/achievement.dart';
import 'package:quran/models/attendance.dart';
import 'package:quran/models/class.dart';
import 'package:quran/models/dailyRecord.dart';
import 'package:quran/models/daily_record.dart';
import 'package:quran/models/resone.dart';
import 'package:quran/models/school.dart';
import 'package:quran/models/user.dart';

import '../api_settings.dart';
import 'package:http/http.dart' as http;

class TeacherApiController with ApiMixin{

  Future<bool> updateTeacher({required User user}) async {
    int id = SharedPreferencesController().user!.id;
    var queryParameters = {
      'first_name': user.first_name,
      'middle_name': user.middle_name,
      'last_name': user.last_name,
      'birth_date': user.birth_date,
      'academic': user.academic,
      'address': user.address,
    };
    var uri = Uri.https('kuttab.sirius-it.dev', '/api/v1/user/$id', queryParameters);
    var response = await http.put(uri, headers: headers);
    print(response.body);
    print(response.statusCode);
    if (isSuccessRequest(response.statusCode)) {
      return jsonDecode(response.body)['status'];
    } else {
      return false;
    }
  }

  Future<bool> updateStudent({required User user}) async {
    var queryParameters = {
      'first_name': user.first_name,
      'middle_name': user.middle_name,
      'last_name': user.last_name,
      'birth_date': user.birth_date,
      'academic': user.academic,
      'address': user.address,
    };
    var uri = Uri.https('kuttab.sirius-it.dev', '/api/v1/user/${user.id}', queryParameters);
    var response = await http.put(uri, headers: headers);
    print(response.body);
    print(response.statusCode);
    if (isSuccessRequest(response.statusCode)) {
      return jsonDecode(response.body)['status'];
    } else {
      return false;
    }
  }

  Future<User> searchStudent({required String username}) async {
    var queryParameters = {
      'username': username,
    };
    var uri = Uri.https('kuttab.sirius-it.dev', '/api/v1/student/search/byUsername', queryParameters);
    var response = await http.get(uri, headers: headers);
    if (isSuccessRequest(response.statusCode)) {
      try {
        User.fromJson(jsonDecode(response.body)['status']);
        return User();
      } catch (e) {
        return User.fromJson(jsonDecode(response.body));
      }
    } else {
      return User();
    }
  }

  Future<List<User>> getTeacherStudent() async {
    int id = SharedPreferencesController().user!.id;
    var response = await http.get(getUrl("https://kuttab.sirius-it.dev/api/v1/teacher/$id/students"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer 34|WV1j7T5xXaZ6Xhd8DszihHelfZBCqMTCEZuuYzsM',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonArray) => User.fromJson(jsonArray)).toList();
    } else {
      print('erorr');
      return [];
    }
  }

  Future<School> getSchool() async {
    int id = SharedPreferencesController().user!.school_id;
    print(id);
    var response = await http.get(getUrl("https://kuttab.sirius-it.dev/api/v1/school/$id"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer 34|WV1j7T5xXaZ6Xhd8DszihHelfZBCqMTCEZuuYzsM',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    });
    print(response.statusCode);
    if (isSuccessRequest(response.statusCode)) {
      return School.fromJson(jsonDecode(response.body)['data']);
    } else {
      print('erorr');
      return School();
    }
  }

  Future<User> getUserLogin() async {
    int id = SharedPreferencesController().user!.id;
    print(id);
    var response = await http.get(getUrl("https://kuttab.sirius-it.dev/api/v1/user/$id"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer 34|WV1j7T5xXaZ6Xhd8DszihHelfZBCqMTCEZuuYzsM',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    });
    print(response.statusCode);
    if (isSuccessRequest(response.statusCode)) {
      return User.fromJson(jsonDecode(response.body)['data']);
    } else {
      print('erorr');
      return User();
    }
  }

  Future<User> getStudent({required int id}) async {
    print(id);
    var response = await http.get(getUrl("https://kuttab.sirius-it.dev/api/v1/user/$id"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer 34|WV1j7T5xXaZ6Xhd8DszihHelfZBCqMTCEZuuYzsM',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    });
    print(response.statusCode);
    if (isSuccessRequest(response.statusCode)) {
      return User.fromJson(jsonDecode(response.body)['data']);
    } else {
      print('erorr');
      return User();
    }
  } // ??

  Future<List<Achievement>> getParentChildren() async {
    int id = SharedPreferencesController().user!.id;
    var response = await http.get(getUrl("https://kuttab.sirius-it.dev/api/v1/parent/$id/children"), headers: {
      HttpHeaders.authorizationHeader: 'Bearer 34|WV1j7T5xXaZ6Xhd8DszihHelfZBCqMTCEZuuYzsM',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept': 'application/json'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonArray) => Achievement.fromJson(jsonArray)).toList();
    } else {
      print('erorr');
      return [];
    }
  }

  Future<List<AttendanceReasons>> getResone() async {
    var response = await http.get(getUrl(ApiSettings.RESONE), headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonArray) => AttendanceReasons.fromJson(jsonArray)).toList();
    } else {
      print('erorr');
      return [];
    }
  }

  // Future<bool> setAttendance({required Attendance attendance}) async{
  //   var response = await http.post(getUrl(ApiSettings.ATTENDANCE), headers: header, body: {
  //     'is_attended': attendance.isAttended,
  //     'reason': attendance.reason,
  //     'date': attendance.date,
  //     'user_id': attendance.userId,
  //   });
  //   print(response.statusCode);
  //   if (isSuccessRequest(response.statusCode)) {
  //     return jsonDecode(response.body)['status'] as bool;
  //   } else {
  //     return false;
  //   }
  // } // ??

  Future<List<Achievement>> getStudentAchievement({required String date, required String lastRecord}) async {
    int id = SharedPreferencesController().user!.id;
    var queryParameters = {
      'date': date,
      'attend': '',
      'lastRecord': lastRecord,
    };
    var uri = Uri.https('kuttab.sirius-it.dev', '/api/v1/teacher/$id/students', queryParameters);

    print("\n\n\n\n here we are in getStudentAchievement");
        var response = await http.get(uri, headers: headers);
    // print(response.body);
    // print('Achievement' + response.statusCode.toString());
    if (isSuccessRequest(response.statusCode)) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonArray) => Achievement.fromJson(jsonArray)).toList();
    } else {
      return [];
    }
  }

  Future<List<Achievement>> getChildrenAchievement({required String date}) async {
    int id = SharedPreferencesController().user!.id;
    var queryParameters = {
      'date': date,
    };
    var uri = Uri.https('kuttab.sirius-it.dev', '/api/v1/parent/$id/children', queryParameters);
    var response = await http.get(uri, headers: headers);
    print(response.body);
    print('Achievement' + response.statusCode.toString());
    if (isSuccessRequest(response.statusCode)) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonArray) => Achievement.fromJson(jsonArray)).toList();
    } else {
      return [];
    }
  }

  Future<List<DailyRecord2>> getSingleStudentAchievement({required String from, required String to, required int id}) async {
    var queryParameters = {
      'from': from,
      'to': to,
    };
    var uri = Uri.https('kuttab.sirius-it.dev', '/api/v1/student/$id/lastRecord/byDate', queryParameters);
    var response = await http.get(uri, headers: headers);
    print(response.body);
    if (isSuccessRequest(response.statusCode)) {
      var jsonArray = jsonDecode(response.body) as List;
      return jsonArray.map((jsonArray) => DailyRecord2.fromJson(jsonArray)).toList();
    } else {
      return [];
    }
  }

  // Future<List<DailyRecord>> getSingleStudentAchievement2({required String limit, required int id}) async {
  //   var queryParameters = {
  //     'limit': limit
  //   };
  //   var uri = Uri.https('kuttab.sirius-it.dev', '/api/v1/student/$id/lastRecord/byLimit', queryParameters);
  //   var response = await http.get(uri, headers: headers);
  //   print(response.body);
  //   if (isSuccessRequest(response.statusCode)) {
  //     var jsonArray = jsonDecode(response.body) as List;
  //     return jsonArray.map((jsonArray) => DailyRecord.fromJson(jsonArray)).toList();
  //   } else {
  //     return [];
  //   }
  // }

  Future<bool> setDailyRecord({required DailyRecord dailyRecord}) async{
    var headers = jsonHeader;
    var request = http.Request('POST', getUrl(ApiSettings.DAILY_RECORD));
    request.body = json.encode({
      "type": dailyRecord.type,
      "school_id": dailyRecord.schoolId,
      "teacher_id": dailyRecord.teacherId,
      "student_id": dailyRecord.studentId,
      "date": dailyRecord.date,
      "review": dailyRecord.review,
      "score": dailyRecord.score,
      "quraan": {
        "from_sura": dailyRecord.quraan.fromSura,
        "from_aya": dailyRecord.quraan.fromAya,
        "to_sura": dailyRecord.quraan.toSura,
        "to_aya": dailyRecord.quraan.toAya,
        "type_id": dailyRecord.quraan.typeId
      }
    });
    request.headers.addAll(headers);

    var response = await request.send();
    final res = await http.Response.fromStream(response);

    print(res.body);
      if (isSuccessRequest(response.statusCode)) {
        print(response);
        return true;
      } else {
        return false;
      }
  }

  Future<bool> setAttendance({required Attendance attendance}) async{
    var headers = jsonHeader;
    var request = http.Request('POST', getUrl(ApiSettings.ATTENDANCE));
    request.body = json.encode(
      [
        {
          "is_attended" : attendance.isAttended,
          "reason" : attendance.reason,
          "date": attendance.date,
          "user_id" : attendance.userId
        }
      ]
    );

    request.headers.addAll(headers);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(res.body);

    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setMAttendance({required List<Attendance> attendances}) async{
    var headers = jsonHeader;
    var request = http.Request('POST', getUrl(ApiSettings.ATTENDANCE));

    request.body = json.encode(
        attendances.map((v) => v.toJson()).toList()
    );

    request.headers.addAll(headers);
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(res.body);

    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else {
      return false;
    }
  }

}