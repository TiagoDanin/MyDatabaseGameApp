import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<User> data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        isOk: json["isOk"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isOk": isOk,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    this.nomeDeUsuario,
    this.nome,
    this.email,
    this.criadoTempo,
    this.paisId,
  });

  int id;
  String nomeDeUsuario;
  String nome;
  String email;
  DateTime criadoTempo;
  int paisId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nomeDeUsuario: json["nome_de_usuario"],
        nome: json["nome"] == null ? null : json["nome"],
        email: json["email"],
        criadoTempo: DateTime.parse(json["criado_tempo"]),
        paisId: json["pais_id"] == null ? null : json["pais_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome_de_usuario": nomeDeUsuario,
        "nome": nome == null ? null : nome,
        "email": email,
        "criado_tempo": criadoTempo.toIso8601String(),
        "pais_id": paisId == null ? null : paisId,
      };
}
