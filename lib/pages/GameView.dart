import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/GameDeveloper.dart';
import 'package:my_database_game/models/GameDistributor.dart';
import 'package:my_database_game/models/GameGender.dart';
import 'package:my_database_game/models/GameOs.dart';
import 'package:my_database_game/models/GameRate.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/services/api.dart';

class GameView extends StatefulWidget {
  Game game;

  GameView({Key key, this.game}) : super(key: key);

  @override
  GameViewWithState createState() => GameViewWithState();
}

class GameViewWithState extends State<GameView> {
  String name = "Jogo";
  String description;
  String dateRelease;
  String os;
  String genders;
  String developer;
  String distribution;
  String rate;

  void getOsGameState() async {
    GameOs gameOs = await getOsGame(widget.game.id);
    if (gameOs.isOk) {
      setState(() {
        os = gameOs.data.map((data) => data.nome).join(", ");
      });
    }
  }

  void getGendersGameState() async {
    GameGender gameGender = await getGendersGame(widget.game.id);
    if (gameGender.isOk) {
      setState(() {
        genders = gameGender.data.map((data) => data.nome).join(", ");
      });
    }
  }

  void getDistributorGameState() async {
    GameDistributor response = await getDistributorGame(widget.game.id);
    if (response.isOk) {
      setState(() {
        distribution = response.data.map((data) => data.nome).join(", ");
      });
    }
  }

  void getDeveloperGameState() async {
    GameDeveloper response = await getDeveloperGame(widget.game.id);
    if (response.isOk) {
      setState(() {
        developer = response.data.map((data) => data.nome).join(", ");
      });
    }
  }

  void getRatedState() async {
    GameRate response = await getRateGame(widget.game.id);
    if (response.isOk) {
      double rateValue = double.parse(response.data.nota);
      String status = "Crítico";
      if (rateValue >= 2) {
        status = "Apaixonado";
      } else if (rateValue >= 1) {
        status = "Neutro";
      }

      setState(() {
        rate = "$status($rateValue)";
      });
    }
  }

  void restoreState() {
    setState(() {
      name = widget.game.nome;
      description = widget.game.descricao;
      dateRelease = DateFormat('dd/MM/yyyy').format(widget.game.lacamentoData);
    });
  }

  @override
  void initState() {
    super.initState();
    restoreState();
    getOsGameState();
    getGendersGameState();
    getDistributorGameState();
    getDeveloperGameState();
    getRatedState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jogo",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Jogo"),
          leading: IconButton(
            icon: Icon(
              MdiIcons.arrowLeftThick,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Descrição: $description'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Data de lançamento: $dateRelease'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Plataformas: $os'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Genero: $genders'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Desenvolvedora: $developer'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Distribuidora: $distribution'),
            ),
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(
                'Avaliações',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Nota: $rate'),
            ),
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(
                'Comentários',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: const Icon(Icons.article),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
