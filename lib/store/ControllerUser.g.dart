// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ControllerUser.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerUser on ControllerUserBase, Store {
  final _$userIdAtom = Atom(name: 'ControllerUserBase.userId');

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$ControllerUserBaseActionController =
      ActionController(name: 'ControllerUserBase');

  @override
  void deleteUser() {
    final _$actionInfo = _$ControllerUserBaseActionController.startAction(
        name: 'ControllerUserBase.deleteUser');
    try {
      return super.deleteUser();
    } finally {
      _$ControllerUserBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userId: ${userId}
    ''';
  }
}
