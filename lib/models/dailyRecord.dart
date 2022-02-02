class DailyRecord {
  late String type;
  late int schoolId;
  late int teacherId;
  late int studentId;
  late String date;
  late String review;
  late  int score;
  late Quraan quraan;

  DailyRecord();

  DailyRecord.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    schoolId = json['school_id'];
    teacherId = json['teacher_id'];
    studentId = json['student_id'];
    date = json['date'];
    review = json['review'];
    score = json['score'];
    quraan =
    (json['quraan'] != null ? new Quraan.fromJson(json['quraan']) : null)!;
  }
}

class Quraan {
  late String fromSura;
  late String fromAya;
  late String toSura;
  late String toAya;
  late int typeId;

  Quraan({required this.fromSura, required this.toAya, required this.toSura, required this.fromAya, required this.typeId});

  Quraan.fromJson(Map<String, dynamic> json) {
    fromSura = json['from_sura'];
    fromAya = json['from_aya'];
    toSura = json['to_sura'];
    toAya = json['to_aya'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_sura'] = this.fromSura;
    data['from_aya'] = this.fromAya;
    data['to_sura'] = this.toSura;
    data['to_aya'] = this.toAya;
    data['type_id'] = this.typeId;
    return data;
  }

}
