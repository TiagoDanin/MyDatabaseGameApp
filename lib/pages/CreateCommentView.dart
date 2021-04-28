import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/InsertTableInfo.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/store/ControllerUser.dart';
import 'package:provider/provider.dart';

class CreateCommentView extends StatefulWidget {
  int gameId;

  CreateCommentView({Key key, this.gameId}) : super(key: key);

  @override
  CreateCommentViewWithState createState() => CreateCommentViewWithState();
}

class CreateCommentViewWithState extends State<CreateCommentView> {
  ControllerUser userController = ControllerUser();
  final TextEditingController textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userController = Provider.of<ControllerUser>(context);
  }

  @override
  void initState() {
    super.initState();
  }

  void sendComment() async {
    InsertTableInfo tableInfo = await createComment(widget.gameId, userController.userId, textController.text);

    bool isValidComment = tableInfo.isOk;
    if (isValidComment) {
      Navigator.of(context).pop();
    } else {
      final snackBar = SnackBar(content: Text('Há um campo inválido.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Comentário",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Comentário"),
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
                sendComment();
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
                  labelText: "Escreva um comentario",
                ),
                maxLength: 4000,
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
