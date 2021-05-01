import 'dart:convert';

OsList gendersFromJson(String str) => OsList.fromJson(json.decode(str));

String gendersToJson(OsList data) => json.encode(data.toJson());

class OsList {
  OsList({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<Os> data;

  factory OsList.fromJson(Map<String, dynamic> json) => OsList(
        isOk: json["isOk"],
        data: List<Os>.from(json["data"].map((x) => Os.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isOk": isOk,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Os {
  Os({
    this.id,
    this.nome,
  });

  int id;
  String nome;

  factory Os.fromJson(Map<String, dynamic> json) => Os(
        id: json["id"],
        nome: json["nome"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
      };
}
