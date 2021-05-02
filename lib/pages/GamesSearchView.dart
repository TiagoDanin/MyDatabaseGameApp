import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/widgets/CardItemMenu.dart';

import 'GameView.dart';

class GamesSearchView extends StatefulWidget {
  String searchQuery;

  GamesSearchView({Key key, this.searchQuery}) : super(key: key);

  @override
  GamesSearchViewWithState createState() => GamesSearchViewWithState();
}

class GamesSearchViewWithState extends State<GamesSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games Encontrados"),
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeftThick,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<Games>(
          future: getSearchGames(widget.searchQuery),
          builder: (BuildContext context, AsyncSnapshot<Games> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isOk) {
                if (snapshot.data.data.length <= 0) {
                  return Center(
                    child: Text(
                      "Sem resultados!",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  );
                }

                return GridView.count(
                  crossAxisCount: 1,
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
