class AttendanceReasons {
  late int id;
  late String title;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  AttendanceReasons();

  AttendanceReasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
