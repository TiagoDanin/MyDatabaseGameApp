import 'package:mobx/mobx.dart';

part 'ControllerUser.g.dart';

class ControllerUser = ControllerUserBase with _$ControllerUser;

abstract class ControllerUserBase with Store {
  @observable
  int userId = 0;

  @action
  void deleteUser() {
    userId = 0;
  }
}