import 'package:quran/models/achievementRecord.dart';
import 'package:quran/models/attendance.dart';

import 'dailyRecord.dart';


// class Achievement {
//   int id = 0;
//   String username = '';
//   String password = '';
//   String type = '';
//   int school_id = 0;
//   String nationality = '';
//   String country = '';
//   String city = '';
//   String address = '';
//   String birth_date = '';
//   String email = '';
//   int mobile_number = 0;
//   int telephone_number = 0;
//   String image = '';
//   String first_name = '';
//   String middle_name = '';
//   String last_name = '';
//   String academic = '';
//   String created_at = '';
//   int created_by = 0;
//   String updated_at = '';
//   int? updated_by = 0;
//   String? token = '';
//   Attendance? isAttendance;
//   AchievementRecord? lastRecord;
//
//   Achievement();
//
//   Achievement.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     password = json['password'];
//     type = json['type'];
//     school_id = json['school_id'];
//     nationality = json['nationality'];
//     country = json['country'];
//     city = json['city'];
//     address = json['address'];
//     birth_date = json['birth_date'];
//     mobile_number = json['mobile_number'];
//     telephone_number = json['telephone_number'];
//     image = json['image'];
//     first_name = json['first_name'];
//     middle_name = json['middle_name'];
//     last_name = json['last_name'];
//     academic = json['academic'];
//     created_at = json['created_at'];
//     created_by = json['created_by'];
//     updated_at = json['updated_at'];
//     updated_by = json['updated_by'];
//     token = json['token'];
//     isAttendance = json['isAttendance'];
//     lastRecord = json['lastRecord'];
//   }
// }
class Achievement {
  late int id;
  late String uid;
  late String username;
  late String email;
  String? emailVerifiedAt;
  late String password;
  late String type;
  late int schoolId;
  late String nationality;
  late String country;
  late String city;
  late String address;
  late String birthDate;
  int? mobileNumber;
  int? telephoneNumber;
  late String image;
  late String firstName;
  late String middleName;
  late String lastName;
  late String academic;
  int? createdBy;
  int? updatedBy;
  String? rememberToken;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  late bool isAttendance;
  late bool isDailyRecord;
  late bool isRecord;
  // IsAttendance? isAttendance;
  LastRecord? lastRecord;

  Achievement();

  Achievement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    type = json['type'];
    schoolId = json['school_id'];
    nationality = json['nationality'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    birthDate = json['birth_date'];
    mobileNumber = json['mobile_number'];
    telephoneNumber = json['telephone_number'];
    image = json['image'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    academic = json['academic'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    rememberToken = json['remember_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAttendance = json['isAttendance'];
    isDailyRecord = json['isDailyRecord'];
    isRecord = json['isRecord'];
    lastRecord = json['daily_record'] != null
        ? new LastRecord.fromJson(json['daily_record'])
        : null;
  }

}

// class IsAttendance {
//   int? id;
//   late String isAttended;
//   late String reason;
//   late String date;
//   late int userId;
//   int? deletedAt;
//   String? createdAt;
//   String? updatedAt;
//
//   IsAttendance();
//
//   IsAttendance.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isAttended = json['is_attended'];
//     reason = json['reason'];
//     date = json['date'];
//     userId = json['user_id'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
// }

class LastRecord {
  late int id;
  late int dailyRecordId;
  late String fromSura;
  late String fromAya;
  late String toSura;
  late String toAya;
  int? deletedAt;
  String? createdAt;
  String? updatedAt;
  late int typeId;

  LastRecord();

  LastRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dailyRecordId = json['daily_record_id'];
    fromSura = json['from_sura'];
    fromAya = json['from_aya'];
    toSura = json['to_sura'];
    toAya = json['to_aya'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }


}
