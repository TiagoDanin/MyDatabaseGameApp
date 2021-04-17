import 'dart:convert';

Games gamesFromJson(String str) => Games.fromJson(json.decode(str));

String gamesToJson(Games data) => json.encode(data.toJson());

class Games {
  Games({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<Game> data;

  factory Games.fromJson(Map<String, dynamic> json) => Games(
        isOk: json["isOk"],
        data: List<Game>.from(json["data"].map((x) => Game.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isOk": isOk,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Game {
  Game({
    this.id,
    this.nome,
    this.descricao,
    this.lacamentoData,
    this.steamId,
  });

  int id;
  String nome;
  String descricao;
  DateTime lacamentoData;
  int steamId;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"],
        lacamentoData: DateTime.parse(json["lacamento_data"]),
        steamId: json["steam_id"] == null ? null : json["steam_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
        "lacamento_data": lacamentoData.toIso8601String(),
        "steam_id": steamId == null ? null : steamId,
      };
}
