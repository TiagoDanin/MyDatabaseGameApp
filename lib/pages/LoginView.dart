import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_database_game/models/Comments.dart';
import 'package:my_database_game/pages/HomeView.dart';
import 'package:my_database_game/store/ControllerUser.dart';
import 'package:provider/provider.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/models/Users.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  LoginViewWithState createState() => LoginViewWithState();
}

class LoginViewWithState extends State<LoginView> {
  ControllerUser userController = ControllerUser();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userController = Provider.of<ControllerUser>(context);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void doLogin(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    userController.deleteUser();

    Users users = await isLoginValid(username, password);

    bool isValidLogin = users.isOk && users.data.length > 0;
    if (isValidLogin) {
      User user = users.data[0];
      userController.userId = user.id;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeView()), ModalRoute.withName('/'));
    } else {
      final snackBar = SnackBar(content: Text('Usuário e/ou senha inválidos.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    usernameController.text = "tiagoedge"; // TODO remove in final version
    passwordController.text = "123456"; // TODO remove in final version

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuário',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 15,
              ),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
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
                  doLogin(context);
                },
                child: Text(
                  'Entrar',
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
                // TDO open singup page
              },
              child: Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }
}
