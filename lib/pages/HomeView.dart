import 'package:flutter/material.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/models/Genders.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/widgets/CardItemMenu.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  HomeViewWithState createState() => HomeViewWithState();
}

class HomeViewWithState extends State<HomeView> {
  String currentCategory = "";
  Map<String, String> category = {};

  void getCurrentCategory() async {
    category = {};
    category[""] = "Todos";

    Genders genders = await getAllGenres();
    if (genders.isOk) {
      genders.data.forEach((genrer) {
        category["${genrer.id}"] = genrer.nome;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text("MyDatabaseGame"),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'Menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'Pesquisar',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          PopupMenuButton<String>(
              icon: Icon(Icons.tune),
              onSelected: (String result) {
                setState(() {
                  currentCategory = result;
                });
              },
              itemBuilder: (BuildContext context) {
                return category.entries.map((entry) {
                  return PopupMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList();
              })
        ],
      ),
      body: FutureBuilder<Games>(
          future: getAllGamesList(currentCategory),
          builder: (BuildContext context, AsyncSnapshot<Games> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isOk) {
                return GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(8.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: snapshot.data.data
                      .map(
                        (game) => CardItemMenu(
                            title: game.nome,
                            description: game.descricao,
                            onPressed: () {
                              // TODO
                            }),
                      )
                      .toList(),
                );
              }

              return Center(
                child: Text(
                  "Houve umna falha de conexão!",
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
