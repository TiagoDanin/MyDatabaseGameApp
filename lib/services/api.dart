import 'package:dio/dio.dart';
import 'package:my_database_game/models/Businesses.dart';
import 'package:my_database_game/models/Comments.dart';
import 'package:my_database_game/models/GameDeveloper.dart';
import 'package:my_database_game/models/GameDistributor.dart';
import 'package:my_database_game/models/GameGender.dart';
import 'package:my_database_game/models/GameOs.dart';
import 'package:my_database_game/models/GameRate.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/models/Genders.dart';
import 'package:my_database_game/models/InsertTableInfo.dart';
import 'package:my_database_game/models/Item.dart';
import 'package:my_database_game/models/OsList.dart';
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

Future<Games> getDistributorGames(int id) async {
  String url = '$apiBaseUrl/getDistributorGames';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "id": id,
    });
    if (response.statusCode == 200) {
      return Games.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Games(isOk: false);
}

Future<Games> getDeveloperGames(int id) async {
  String url = '$apiBaseUrl/getDeveloperGames';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "id": id,
    });
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

Future<Comments> listCommentsGame(int gameId) async {
  String url = '$apiBaseUrl/listCommentsGame';
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
    Response response = await Dio().post(url, data: {
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
    Response response = await Dio().post(url, data: {
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

Future<GameOs> getOsGame(int gameId) async {
  String url = '$apiBaseUrl/getOsGame';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "gameId": gameId,
    });
    if (response.statusCode == 200) {
      return GameOs.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return GameOs(isOk: false);
}

Future<GameGender> getGendersGame(int gameId) async {
  String url = '$apiBaseUrl/getGendersGame';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "gameId": gameId,
    });
    if (response.statusCode == 200) {
      return GameGender.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return GameGender(isOk: false);
}

Future<GameDistributor> getDistributorGame(int gameId) async {
  String url = '$apiBaseUrl/getDistributorGame';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "gameId": gameId,
    });
    if (response.statusCode == 200) {
      return GameDistributor.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return GameDistributor(isOk: false);
}

Future<GameDeveloper> getDeveloperGame(int gameId) async {
  String url = '$apiBaseUrl/getDeveloperGame';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "gameId": gameId,
    });
    if (response.statusCode == 200) {
      return GameDeveloper.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return GameDeveloper(isOk: false);
}

Future<GameRate> getRateGame(int gameId) async {
  String url = '$apiBaseUrl/getRateGame';
  try {
    Response response = await Dio().get(url, queryParameters: {
      "gameId": gameId,
    });
    if (response.statusCode == 200) {
      return GameRate.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return GameRate(isOk: false);
}

Future<InsertTableInfo> createComment(int gameId, int userId, String text) async {
  String url = '$apiBaseUrl/createComment';
  try {
    Response response = await Dio().post(url, data: {
      "gameId": gameId,
      "userId": userId,
      "text": text,
    });
    if (response.statusCode == 200) {
      return InsertTableInfo.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return InsertTableInfo(isOk: false);
}

Future<Businesses> getBusinesses() async {
  String url = '$apiBaseUrl/getBusinesses';
  try {
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      return Businesses.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return Businesses(isOk: false);
}

Future<OsList> getAllOs() async {
  String url = '$apiBaseUrl/getAllOs';
  try {
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      return OsList.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return OsList(isOk: false);
}

Future<InsertTableInfo> createBusiness(String text) async {
  String url = '$apiBaseUrl/createBusiness';
  try {
    Response response = await Dio().post(url, data: {
      "text": text,
    });
    if (response.statusCode == 200) {
      return InsertTableInfo.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return InsertTableInfo(isOk: false);
}

Future<InsertTableInfo> createGender(String text) async {
  String url = '$apiBaseUrl/createGender';
  try {
    Response response = await Dio().post(url, data: {
      "text": text,
    });
    if (response.statusCode == 200) {
      return InsertTableInfo.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return InsertTableInfo(isOk: false);
}

Future<InsertTableInfo> createGame(
  int userId,
  String name,
  String description,
  String steamId,
  DateTime releaseDate,
  List<Item> genders,
  List<Item> developers,
  List<Item> distributions,
  List<Item> os,
) async {
  String url = '$apiBaseUrl/createGame';

  if (genders.length <= 0 || developers.length <= 0 || distributions.length <= 0 || os.length <= 0) {
    return InsertTableInfo(isOk: false);
  } else if (name.length <= 0 || description.length <= 0) {
    return InsertTableInfo(isOk: false);
  }

  try {
    Response response = await Dio().post(
      url,
      data: {
        "userId": userId,
        "name": name,
        "description": description,
        "steamId": steamId,
        "releaseDate": "${releaseDate.year}/${releaseDate.month}/${releaseDate.day}",
        "genders": genders.map((item) => item.id).join(","),
        "developers": developers.map((item) => item.id).join(","),
        "distributions": distributions.map((item) => item.id).join(","),
        "os": os.map((item) => item.id).join(","),
      },
    );

    if (response.statusCode == 200) {
      return InsertTableInfo.fromJson(response.data);
    }
  } catch (error) {
    print(error);
  }

  return InsertTableInfo(isOk: false);
}
