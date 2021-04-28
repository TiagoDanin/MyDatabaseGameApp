import 'dart:convert';

GameOs gameOsFromJson(String str) => GameOs.fromJson(json.decode(str));

String gameOsToJson(GameOs data) => json.encode(data.toJson());

class GameOs {
  GameOs({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<DataOs> data;

  factory GameOs.fromJson(Map<String, dynamic> json) => GameOs(
    isOk: json["isOk"] == null ? null : json["isOk"],
    data: json["data"] == null ? null : List<DataOs>.from(json["data"].map((x) => DataOs.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isOk": isOk == null ? null : isOk,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataOs {
  DataOs({
    this.nome,
  });

  String nome;

  factory DataOs.fromJson(Map<String, dynamic> json) => DataOs(
    nome: json["nome"] == null ? null : json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
  };
}