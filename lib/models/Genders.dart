import 'dart:convert';

Genders gendersFromJson(String str) => Genders.fromJson(json.decode(str));

String gendersToJson(Genders data) => json.encode(data.toJson());

class Genders {
  Genders({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<Gender> data;

  factory Genders.fromJson(Map<String, dynamic> json) => Genders(
        isOk: json["isOk"],
        data: List<Gender>.from(json["data"].map((x) => Gender.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isOk": isOk,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Gender {
  Gender({
    this.id,
    this.nome,
  });

  int id;
  String nome;

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        nome: json["nome"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
      };
}
