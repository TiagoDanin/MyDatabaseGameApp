import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/models/Genders.dart';
import 'package:my_database_game/pages/DevelopersView.dart';
import 'package:my_database_game/pages/DistributorView.dart';
import 'package:my_database_game/pages/GamesTopView.dart';
import 'package:my_database_game/pages/UsersTopView.dart';
import 'package:my_database_game/pages/UsersView.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/widgets/CardItemMenu.dart';

import 'GameView.dart';

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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('My Database Game'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Games'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
            ),
            ListTile(
              title: Text('Games Top'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GamesTopView()),
                );
              },
            ),
            ListTile(
              title: Text('Usuários'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UsersView()),
                );
              },
            ),
            ListTile(
              title: Text('Usuários Top'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UsersTopView()),
                );
              },
            ),
            ListTile(
              title: Text('Distribuidores de Jogos'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DistributorView()),
                );
              },
            ),
            ListTile(
              title: Text('Desenvolvedores de Jogos'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DevelopersView()),
                );
              },
            ),
          ],
        ),
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
                            icon: MdiIcons.controllerClassic,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => GameView(game: game)),
                              );
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
