import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:my_database_game/models/Businesses.dart';
import 'package:my_database_game/models/Genders.dart';
import 'package:my_database_game/models/InsertTableInfo.dart';
import 'package:my_database_game/models/Item.dart';
import 'package:my_database_game/models/OsList.dart';
import 'package:my_database_game/pages/CreateBusinessView.dart';
import 'package:my_database_game/pages/CreateGenderView.dart';
import 'package:my_database_game/pages/HomeView.dart';
import 'package:my_database_game/services/api.dart';
import 'package:my_database_game/store/ControllerUser.dart';
import 'package:provider/provider.dart';

class CreateGameView extends StatefulWidget {
  CreateGameView({Key key}) : super(key: key);

  @override
  CreateGameViewWithState createState() => CreateGameViewWithState();
}

class CreateGameViewWithState extends State<CreateGameView> {
  final GlobalKey<ScaffoldState> scaffKey = GlobalKey<ScaffoldState>();

  ControllerUser userController = ControllerUser();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController steamIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<MultiSelectItem<Item>> listBusinesses = [];
  List<MultiSelectItem<Item>> listGender = [];
  List<MultiSelectItem<Item>> listOs = [];

  List<Item> selectListDistributions = [];
  List<Item> selectListDevelopers = [];
  List<Item> selectListOs = [];
  List<Item> selectListGenders = [];

  DateTime gameReleaseDate = DateTime.now();

  void getBusinessesState() async {
    Businesses businesses = await getBusinesses();
    if (businesses.isOk) {
      setState(() {
        listBusinesses = businesses.data.map((item) => MultiSelectItem<Item>(Item(id: item.id, name: item.nome), item.nome)).toList();
      });
    }
  }

  void getAllGenresState() async {
    Genders genders = await getAllGenres();
    if (genders.isOk) {
      setState(() {
        listGender = genders.data.map((item) => MultiSelectItem<Item>(Item(id: item.id, name: item.nome), item.nome)).toList();
      });
    }
  }

  void getAllOsState() async {
    OsList osList = await getAllOs();
    if (osList.isOk) {
      setState(() {
        listOs = osList.data.map((item) => MultiSelectItem<Item>(Item(id: item.id, name: item.nome), item.nome)).toList();
      });
    }
  }

  void loadAllDataSelect() async {
    getAllGenresState();
    getAllOsState();
    getBusinessesState();
  }

  @override
  void initState() {
    super.initState();
    loadAllDataSelect();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userController = Provider.of<ControllerUser>(context);
  }

  void sendGame(BuildContext context) async {
    InsertTableInfo tableInfo = await createGame(
      userController.userId,
      nameController.text,
      descriptionController.text,
      steamIdController.text,
      gameReleaseDate,
      selectListGenders,
      selectListDevelopers,
      selectListDistributions,
      selectListOs,
    );


    if (tableInfo.isOk) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeView()), ModalRoute.withName('/'));
    } else {
      final snackBar = SnackBar(content: Text('Há um ou mais campos inválidos.'));
      scaffKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Adicionar Game",
      home: Scaffold(
          key: scaffKey,
          appBar: AppBar(
            title: Text("Adicionar Game"),
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
                  sendGame(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: nameController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            hintText: 'Nome (Obrigatório)',
                          ),
                        ),
                        TextField(
                          controller: steamIdController,
                          maxLength: 30,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            labelText: 'Steam ID',
                          ),
                        ),
                        TextField(
                          controller: descriptionController,
                          maxLength: 4000,
                          decoration: InputDecoration(
                            labelText: 'Deescrição',
                            hintText: 'Deescrição (Obrigatório)',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        side: BorderSide(width: 2, color: Colors.blue),
                      ),
                      onPressed: () {
                        DatePicker.showDatePicker(context, showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                          setState(() {
                            gameReleaseDate = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.pt);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Icon(Icons.videogame_asset),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Data de lançamento',
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${gameReleaseDate.day}/${gameReleaseDate.month}/${gameReleaseDate.year}',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 15),
                  MultiSelectDialogField(
                    items: listBusinesses,
                    title: Text("Distribuidores"),
                    selectedColor: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.videogame_asset,
                      color: Colors.blue,
                    ),
                    buttonText: Text(
                      "Selecione uma distribuidora",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      setState(() {
                        selectListDistributions = results;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  MultiSelectDialogField(
                    items: listBusinesses,
                    title: Text("Desenvolvedoras"),
                    selectedColor: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.videogame_asset,
                      color: Colors.blue,
                    ),
                    buttonText: Text(
                      "Selecione uma desenvolvedora",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      setState(() {
                        selectListDevelopers = results;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  MultiSelectDialogField(
                    items: listGender,
                    title: Text("Gêneros"),
                    selectedColor: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.videogame_asset,
                      color: Colors.blue,
                    ),
                    buttonText: Text(
                      "Selecione um gênero",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      setState(() {
                        selectListGenders = results;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  MultiSelectDialogField(
                    items: listOs,
                    title: Text("Plataformas"),
                    selectedColor: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.videogame_asset,
                      color: Colors.blue,
                    ),
                    buttonText: Text(
                      "Selecione uma plataforma",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      setState(() {
                        selectListOs = results;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_arrow,
            foregroundColor: Colors.white,
            animatedIconTheme: IconThemeData(size: 22),
            backgroundColor: Colors.blue,
            visible: true,
            curve: Curves.bounceIn,
            children: [
              SpeedDialChild(
                foregroundColor: Colors.white,
                child: Icon(Icons.assignment_turned_in),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBusinessView())).then((_) {
                    loadAllDataSelect();
                  });
                },
                label: 'Nova Empresa',
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                labelBackgroundColor: Colors.blue,
              ),
              SpeedDialChild(
                foregroundColor: Colors.white,
                child: Icon(Icons.assignment_turned_in),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateGenderView())).then((_) {
                    loadAllDataSelect();
                  });
                },
                label: 'Novo Gênero',
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                labelBackgroundColor: Colors.blue,
              )
            ],
          )),
    );
  }
}
