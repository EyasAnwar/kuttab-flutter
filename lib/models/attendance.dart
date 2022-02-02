class Attendance{
  late bool isAttended;
  late String reason;
  late String date;
  late String userId;

  Attendance({required this.isAttended, required this.reason, required this.date, required this.userId});

  Attendance.fromJson(Map<String, dynamic> json) {
    isAttended = json['is_attended'];
    reason = json['reason'];
    date = json['date'];
    userId = json['user_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_attended'] = this.isAttended;
    data['reason'] = this.reason;
    data['date'] = this.date;
    data['user_id'] = this.userId;
    return data;
  }

}