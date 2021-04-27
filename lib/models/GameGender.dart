import 'dart:convert';

GameGender gameGenderFromJson(String str) => GameGender.fromJson(json.decode(str));

String gameGenderToJson(GameGender data) => json.encode(data.toJson());

class GameGender {
  GameGender({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<DataGender> data;

  factory GameGender.fromJson(Map<String, dynamic> json) => GameGender(
    isOk: json["isOk"] == null ? null : json["isOk"],
    data: json["data"] == null ? null : List<DataGender>.from(json["data"].map((x) => DataGender.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isOk": isOk == null ? null : isOk,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataGender {
  DataGender({
    this.nome,
  });

  String nome;

  factory DataGender.fromJson(Map<String, dynamic> json) => DataGender(
    nome: json["nome"] == null ? null : json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
  };
}
