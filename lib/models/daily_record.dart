class DailyRecord2 {
  late bool isAttended;
  late bool isDailyRecord;
  late bool isRecord;
  late String day;
  List<DailyRecord3>? dailyRecord;

  DailyRecord2();

  DailyRecord2.fromJson(Map<String, dynamic> json) {
    isAttended = json['is_attended'];
    isDailyRecord = json['isDailyRecord'];
    isRecord = json['isRecord'];
    day = json['day'];
    if (json['dailyRecord'] != null) {
      dailyRecord = <DailyRecord3>[];
      json['dailyRecord'].forEach((v) {
        dailyRecord!.add(new DailyRecord3.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_attended'] = this.isAttended;
    data['isDailyRecord'] = this.isDailyRecord;
    data['isRecord'] = this.isRecord;
    data['day'] = this.day;
    if (this.dailyRecord != null) {
      data['dailyRecord'] = this.dailyRecord!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyRecord3 {
  late int id;
  late int dailyRecordId;
  late String fromSura;
  late String fromAya;
  late String toSura;
  late String toAya;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  late int typeId;

  DailyRecord3();

  DailyRecord3.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['daily_record_id'] = this.dailyRecordId;
    data['from_sura'] = this.fromSura;
    data['from_aya'] = this.fromAya;
    data['to_sura'] = this.toSura;
    data['to_aya'] = this.toAya;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type_id'] = this.typeId;
    return data;
  }
}
