import 'package:flutter/material.dart';
import 'package:my_database_game/pages/LoginView.dart';
import 'package:my_database_game/store/ControllerUser.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ControllerUser>(
          create: (_) => ControllerUser(),
        ),
      ],
      child: MaterialApp(
        title: 'MyDatabaseGame',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginView(),
      ),
    );
  }
}
