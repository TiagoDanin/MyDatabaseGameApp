import 'dart:convert';

Businesses businessesFromJson(String str) => Businesses.fromJson(json.decode(str));

String businessesToJson(Businesses data) => json.encode(data.toJson());

class Businesses {
  Businesses({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<DataBusinesses> data;

  factory Businesses.fromJson(Map<String, dynamic> json) => Businesses(
    isOk: json["isOk"] == null ? null : json["isOk"],
    data: json["data"] == null ? null : List<DataBusinesses>.from(json["data"].map((x) => DataBusinesses.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isOk": isOk == null ? null : isOk,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataBusinesses {
  DataBusinesses({
    this.id,
    this.nome,
    this.paisId,
  });

  int id;
  String nome;
  int paisId;

  factory DataBusinesses.fromJson(Map<String, dynamic> json) => DataBusinesses(
    id: json["id"] == null ? null : json["id"],
    nome: json["nome"] == null ? null : json["nome"],
    paisId: json["pais_id"] == null ? null : json["pais_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nome": nome == null ? null : nome,
    "pais_id": paisId == null ? null : paisId,
  };
}
