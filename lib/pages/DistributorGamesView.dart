import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/widgets/CardItemMenu.dart';

import 'GameView.dart';

// ignore: must_be_immutable
class DistributorGamesView extends StatefulWidget {
  int id;

  DistributorGamesView({Key key, this.id}) : super(key: key);

  @override
  DistributorGamesViewWithState createState() => DistributorGamesViewWithState();
}

class DistributorGamesViewWithState extends State<DistributorGamesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogos da Distribuidora"),
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
          future: getDistributorGames(widget.id),
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
                          },
                        ),
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
