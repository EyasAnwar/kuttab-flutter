class School {
  int id = 0;
  String name = '';
  String description = '';
  String country = '';
  String city = '';
  String address = '';
  String logo = '';
  String language = '';

  School();

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    logo = json['logo'];
    language = json['language'];
  }
}
