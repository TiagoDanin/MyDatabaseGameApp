import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/Businesses.dart';
import 'package:my_database_game/pages/DeveloperGamesView.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/widgets/CardItemMenu.dart';

// ignore: must_be_immutable
class DevelopersView extends StatefulWidget {
  DevelopersView({Key key}) : super(key: key);

  @override
  DevelopersViewWithState createState() => DevelopersViewWithState();
}

class DevelopersViewWithState extends State<DevelopersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desenvolvedores de Jogos"),
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeftThick,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<Businesses>(
          future: getBusinesses(),
          builder: (BuildContext context, AsyncSnapshot<Businesses> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isOk) {
                return GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(8.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: snapshot.data.data
                      .map(
                        (data) => CardItemMenu(
                          title: data.nome,
                          description: "",
                          icon: MdiIcons.xml,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => DeveloperGamesView(id: data.id)),
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
