import 'package:dio/dio.dart';
import 'package:my_database_game/models/Games.dart';

String apiBaseUrl = "http://192.168.0.10:8087/api/v1";

Future<Games> getAllGamesList() async {
  String url = '$apiBaseUrl/games';
  try {
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      return Games.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Games(isOk: false);
}
