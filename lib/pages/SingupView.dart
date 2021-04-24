import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/InsertTableInfo.dart';
import 'package:my_database_game/pages/LoginView.dart';
import 'package:my_database_game/services/api.dart';

class SingupView extends StatefulWidget {
  SingupView({Key key}) : super(key: key);

  @override
  SingupViewWithState createState() => SingupViewWithState();
}

class SingupViewWithState extends State<SingupView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void doSingup(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;
    String email = emailController.text;
    String name = nameController.text;

    InsertTableInfo tableInfo = await createLogin(username, password, email, name);

    bool isValidLogin = tableInfo.isOk;
    if (isValidLogin) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginView()), ModalRoute.withName('/'));
    } else {
      final snackBar = SnackBar(content: Text('Há um ou mais campos inválidos.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Icon(
                    MdiIcons.controllerClassic,
                    size: 150,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 0,
              ),
              child: TextField(
                controller: usernameController,
                maxLength: 16,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuário',
                  hintText: 'Usuário (Obrigatório)',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 0,
              ),
              child: TextField(
                controller: nameController,
                maxLength: 30,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 0,
              ),
              child: TextField(
                controller: emailController,
                maxLength: 255,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Email (Obrigatório)',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 15,
              ),
              child: TextField(
                obscureText: true,
                maxLength: 32,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  hintText: 'Senha (Obrigatório)',
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  doSingup(context);
                },
                child: Text(
                  'Criar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              child: Text('Fazer Login'),
            ),
          ],
        ),
      ),
    );
  }
}
