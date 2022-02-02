import 'package:quran/models/surah.dart';

class AchievementRecord{
  late int id;
  late int daily_record_id;
  late String from_sura;
  late String from_aya;
  late String to_sura;
  late String to_aya;
  late String? deleted_at;
  late String created_at;
  late String updated_at;
  late int type_id;

  AchievementRecord();

  AchievementRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    daily_record_id = json['daily_record_id'];
    from_sura = json['from_sura'];
    from_aya = json['from_aya'];
    to_sura = json['to_sura'];
    to_aya = json['to_aya'];
    deleted_at = json['deleted_at'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    type_id = json['type_id'];
  }

}