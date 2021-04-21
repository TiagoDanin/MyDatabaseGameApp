import 'dart:convert';

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));

String commentsToJson(Comments data) => json.encode(data.toJson());

class Comments {
  Comments({
    this.isOk,
    this.data,
  });

  bool isOk;
  List<Comment> data;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        isOk: json["isOk"],
        data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isOk": isOk,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.id,
    this.texto,
    this.nome,
  });

  int id;
  String texto;
  String nome;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        texto: json["texto"],
        nome: json["nome"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "texto": texto,
        "nome": nome,
      };
}
