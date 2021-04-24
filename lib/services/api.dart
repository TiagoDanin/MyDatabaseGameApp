import 'package:dio/dio.dart';
import 'package:my_database_game/models/Comments.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/models/Genders.dart';
import 'package:my_database_game/models/InsertTableInfo.dart';
import 'package:my_database_game/models/Users.dart';

String apiBaseUrl = "http://192.168.0.10:8087/api/v1";

Future<Games> getAllGamesList(String currentCategoryId) async {
  String url = '$apiBaseUrl/getAllGamesByGender';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "genderId": currentCategoryId,
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
  String url = '$apiBaseUrl/getAllGenders';
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

Future<Users> getAllUsers() async {
  String url = '$apiBaseUrl/getAllUsers';
  try {
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      return Users.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Users(isOk: false);
}

Future<Games> getAllGamesSoon() async {
  String url = '$apiBaseUrl/getAllGamesSoon';
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

Future<Games> getAllGamesTop() async {
  String url = '$apiBaseUrl/getAllGamesTop';
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

Future<Games> getAllGamesTopComments() async {
  String url = '$apiBaseUrl/getAllGamesTopComments';
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

Future<Users> getAllUsersTops() async {
  String url = '$apiBaseUrl/getAllUsersTops';
  try {
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      return Users.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Users(isOk: false);
}

Future<Comments> getGameComments(String gameId) async {
  String url = '$apiBaseUrl/getGameComments';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "gameId": gameId,
    });
    if (response.statusCode == 200) {
      return Comments.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Comments(isOk: false);
}

Future<Users> isLoginValid(String username, String password) async {
  String url = '$apiBaseUrl/isLoginValid';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "username": username,
      "password": password,
    });
    if (response.statusCode == 200) {
      return Users.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Users(isOk: false);
}

Future<InsertTableInfo> createLogin(String username, String password, String email, String name) async {
  String url = '$apiBaseUrl/createLoginff';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "username": username,
      "password": password,
      "email": email,
      "name": name,
    });
    if (response.statusCode == 200) {
      return InsertTableInfo.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return InsertTableInfo(isOk: false);
}
