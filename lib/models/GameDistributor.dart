import 'dart:convert';

GameDistributor gameDistributorFromJson(String str) => GameDistributor.fromJson(json.decode(str));

String gameDistributorToJson(GameDistributor data) => json.encode(data.toJson());

class GameDistributor {
  GameDistributor({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<DataDistributor> data;

  factory GameDistributor.fromJson(Map<String, dynamic> json) => GameDistributor(
    isOk: json["isOk"] == null ? null : json["isOk"],
    data: json["data"] == null ? null : List<DataDistributor>.from(json["data"].map((x) => DataDistributor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isOk": isOk == null ? null : isOk,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataDistributor {
  DataDistributor({
    this.nome,
  });

  String nome;

  factory DataDistributor.fromJson(Map<String, dynamic> json) => DataDistributor(
    nome: json["nome"] == null ? null : json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
  };
}
