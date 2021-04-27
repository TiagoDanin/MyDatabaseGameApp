import 'dart:convert';

GameRate gameRateFromJson(String str) => GameRate.fromJson(json.decode(str));

String gameRateToJson(GameRate data) => json.encode(data.toJson());

class GameRate {
  GameRate({
    this.isOk,
    this.data,
  });

  bool isOk;
  DataRate data;

  factory GameRate.fromJson(Map<String, dynamic> json) => GameRate(
    isOk: json["isOk"] == null ? null : json["isOk"],
    data: json["data"] == null ? null : DataRate.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "isOk": isOk == null ? null : isOk,
    "data": data == null ? null : data.toJson(),
  };
}

class DataRate {
  DataRate({
    this.nota,
  });

  String nota;

  factory DataRate.fromJson(Map<String, dynamic> json) => DataRate(
    nota: json["nota"] == null ? null : json["nota"],
  );

  Map<String, dynamic> toJson() => {
    "nota": nota == null ? null : nota,
  };
}