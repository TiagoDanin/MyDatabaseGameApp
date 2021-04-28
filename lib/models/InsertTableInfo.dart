import 'dart:convert';

InsertTableInfo insertTableInfoFromJson(String str) => InsertTableInfo.fromJson(json.decode(str));

String insertTableInfoToJson(InsertTableInfo data) => json.encode(data.toJson());

class InsertTableInfo {
  InsertTableInfo({
    this.isOk,
    this.data,
  });

  bool isOk;
  DataInsertTableInfo data;

  factory InsertTableInfo.fromJson(Map<String, dynamic> json) => InsertTableInfo(
        isOk: json["isOk"],
        data: DataInsertTableInfo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "isOk": isOk,
        "data": data.toJson(),
      };
}

class DataInsertTableInfo {
  DataInsertTableInfo({
    this.fieldCount,
    this.affectedRows,
    this.insertId,
    this.info,
    this.serverStatus,
    this.warningStatus,
  });

  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;

  factory DataInsertTableInfo.fromJson(Map<String, dynamic> json) => DataInsertTableInfo(
        fieldCount: json["fieldCount"],
        affectedRows: json["affectedRows"],
        insertId: json["insertId"],
        info: json["info"],
        serverStatus: json["serverStatus"],
        warningStatus: json["warningStatus"],
      );

  Map<String, dynamic> toJson() => {
        "fieldCount": fieldCount,
        "affectedRows": affectedRows,
        "insertId": insertId,
        "info": info,
        "serverStatus": serverStatus,
        "warningStatus": warningStatus,
      };
}
