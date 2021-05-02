import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/Comments.dart';
import 'package:my_database_game/models/GameDeveloper.dart';
import 'package:my_database_game/models/GameDistributor.dart';
import 'package:my_database_game/models/GameGender.dart';
import 'package:my_database_game/models/GameOs.dart';
import 'package:my_database_game/models/GameRate.dart';
import 'package:my_database_game/models/Games.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/store/ControllerUser.dart';
import 'package:provider/provider.dart';

import 'CreateCommentView.dart';

class GameView extends StatefulWidget {
  Game game;

  GameView({Key key, this.game}) : super(key: key);

  @override
  GameViewWithState createState() => GameViewWithState();
}

class GameViewWithState extends State<GameView> {
  ControllerUser userController = ControllerUser();
  String name = "Jogo";
  String description;
  String dateRelease;
  String os;
  String genders;
  String developer;
  String distribution;
  String rate;
  List<Comment> commentsList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userController = Provider.of<ControllerUser>(context);
  }

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
      } else if (rateValue == 0) {
        status = "Sem nota";
      }

      setState(() {
        rate = "$status($rateValue)";
      });
    }
  }

  void snedRatedState(rateInput) async {
    GameRate response = await sendRateGame(widget.game.id, userController.userId, rateInput);
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

  void getCommentsGame() async {
    Comments comments = await listCommentsGame(widget.game.id);
    if (comments.isOk && comments.data.length > 0) {
      setState(() {
        commentsList = comments.data;
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
    getCommentsGame();
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
          actions: <Widget>[
            PopupMenuButton<int>(
              icon: Icon(MdiIcons.starOutline),
              onSelected: (int result) {
                snedRatedState(result);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Crítico"),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Neutro"),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Text("Apaixonado"),
                  )
                ];
              },
            )
          ],
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
            for (var comment in commentsList)
              ListTile(
                leading: Icon(MdiIcons.commentOutline),
                title: Text('@${comment.nome}: ${comment.texto}'),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateCommentView(gameId: widget.game.id))).then((_) {
              getCommentsGame();
            });
          },
          child: Icon(Icons.article),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
