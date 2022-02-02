import 'package:get/get.dart';

class User{
  int id = 0;
  String username = '';
  String password = '';
  String type = '';
  int school_id = 0;
  String nationality = '';
  String country = '';
  String city = '';
  String address = '';
  String birth_date = '';
  String email = '';
  int mobile_number = 0;
  int telephone_number = 0;
  String image = '';
  String first_name = '';
  String middle_name = '';
  String last_name = '';
  String academic = '';
  String created_at = '';
  int created_by = 0;
  String updated_at = '';
  int? updated_by = 0;
  bool isAttendance = false;
  String? token = '';

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    type = json['type'];
    school_id = json['school_id'];
    nationality = json['nationality'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    birth_date = json['birth_date'];
    mobile_number = json['mobile_number'];
    telephone_number = json['telephone_number'];
    image = json['image'];
    first_name = json['first_name'];
    middle_name = json['middle_name'];
    last_name = json['last_name'];
    academic = json['academic'];
    created_at = json['created_at'];
    created_by = json['created_by'];
    updated_at = json['updated_at'];
    updated_by = json['updated_by'];
    token = json['token'];
  }
}
