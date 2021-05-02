import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/pages/GamesSearchView.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  SearchViewWithState createState() => SearchViewWithState();
}

class SearchViewWithState extends State<SearchView> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pesquisar Game",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pesquisar Game"),
          leading: IconButton(
            icon: Icon(
              MdiIcons.arrowLeftThick,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                semanticLabel: 'Pesquisar',
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GamesSearchView(searchQuery: textController.text),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              title: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                  maxLength: 45),
            ),
          ],
        ),
      ),
    );
  }
}
