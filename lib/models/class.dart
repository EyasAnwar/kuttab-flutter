class SchoolClass{
  late String name;

  SchoolClass();

  SchoolClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}