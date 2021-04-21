import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/Users.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/widgets/CardItemMenu.dart';

class UsersView extends StatefulWidget {
  UsersView({Key key}) : super(key: key);

  @override
  UsersViewWithState createState() => UsersViewWithState();
}

class UsersViewWithState extends State<UsersView> {
  String currentCategory = "";
  Map<String, String> category = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuários"),
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeftThick,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<Users>(
          future: getAllUsers(),
          builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isOk) {
                return GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(8.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: snapshot.data.data
                      .map(
                        (user) => CardItemMenu(
                            title: user.nome ?? "Anónimo",
                            description: "@${user.nomeDeUsuario}",
                            icon: MdiIcons.account,
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
