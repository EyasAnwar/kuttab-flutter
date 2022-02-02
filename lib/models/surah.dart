class Surah {
  late int number;
  late String name;
  late int numberOfAya;

  Surah({required this.number, required this.name, required this.numberOfAya});

  Surah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    numberOfAya = json['numberOfAya'];
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'name': name,
    'numberOfAya': numberOfAya,
  };

}
