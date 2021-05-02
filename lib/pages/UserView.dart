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
import 'package:my_database_game/models/Users.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/store/ControllerUser.dart';
import 'package:provider/provider.dart';

import 'CreateCommentView.dart';

class UserView extends StatefulWidget {
  User user;

  UserView({Key key, this.user}) : super(key: key);

  @override
  UserViewWithState createState() => UserViewWithState();
}

class UserViewWithState extends State<UserView> {
  String name = "Jogo";
  String username;
  String email;
  String createAt;

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.user.nome ?? "Anónimo";
      username = widget.user.nomeDeUsuario;
      createAt = DateFormat('dd/MM/yyyy').format(widget.user.criadoTempo);
      email = widget.user.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Usuário",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Usuário"),
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
              leading: Icon(MdiIcons.account),
              title: Text(
                "@$username",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Nome: $name'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Data de criação: $createAt'),
            ),
            ListTile(
              leading: Icon(Icons.chevron_right_rounded),
              title: Text('Email: $email'),
            ),
          ],
        ),
      ),
    );
  }
}
