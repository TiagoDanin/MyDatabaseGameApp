import 'dart:convert';

GameDeveloper gameDeveloperFromJson(String str) => GameDeveloper.fromJson(json.decode(str));

String gameDeveloperToJson(GameDeveloper data) => json.encode(data.toJson());

class GameDeveloper {
  GameDeveloper({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<DataDeveloper> data;

  factory GameDeveloper.fromJson(Map<String, dynamic> json) => GameDeveloper(
    isOk: json["isOk"] == null ? null : json["isOk"],
    data: json["data"] == null ? null : List<DataDeveloper>.from(json["data"].map((x) => DataDeveloper.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isOk": isOk == null ? null : isOk,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataDeveloper {
  DataDeveloper({
    this.nome,
  });

  String nome;

  factory DataDeveloper.fromJson(Map<String, dynamic> json) => DataDeveloper(
    nome: json["nome"] == null ? null : json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
  };
}
