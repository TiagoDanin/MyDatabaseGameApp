import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/InsertTableInfo.dart';
import 'package:my_database_game/services/api.dart';

class CreateGenderView extends StatefulWidget {
  CreateGenderView({Key key}) : super(key: key);

  @override
  CreateGenderViewWithState createState() => CreateGenderViewWithState();
}

class CreateGenderViewWithState extends State<CreateGenderView> {
  final GlobalKey<ScaffoldState> scaffKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = TextEditingController();

  void send(BuildContext context) async {
    InsertTableInfo tableInfo = await createGender(textController.text);

    bool isValidComment = tableInfo.isOk;
    if (isValidComment) {
      Navigator.of(context).pop();
    } else {
      final snackBar = SnackBar(content: Text('Há um campo inválido.'));
      scaffKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Criar Gênero",
      home: Scaffold(
        key: scaffKey,
        appBar: AppBar(
          title: Text("Criar Gênero"),
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
                MdiIcons.send,
                semanticLabel: 'Enviar',
              ),
              onPressed: () {
                send(context);
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
                  labelText: "Gênero",
                ),
                maxLength: 45
              ),
            ),
          ],
        ),
      ),
    );
  }
}
