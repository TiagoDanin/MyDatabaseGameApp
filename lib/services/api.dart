import 'package:dio/dio.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/models/Genders.dart';

String apiBaseUrl = "http://192.168.0.10:8087/api/v1";

Future<Games> getAllGamesList(String currentCategoryId) async {
  String url = '$apiBaseUrl/games';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "gender": currentCategoryId
    });
    if (response.statusCode == 200) {
      print(response.data);
      return Games.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }
  
  return Games(isOk: false);
}

Future<Genders> getAllGenres() async {
  String url = '$apiBaseUrl/genders';
  try {
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      return Genders.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Genders(isOk: false);
}
