import 'package:crud_project/app/app_controller.dart';
import 'package:crud_project/app/model/user.dart';
import 'package:crud_project/app/modules/login/repository/login_repository.dart';
import 'package:crud_project/app/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  AppController appController = Modular.get();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @observable
  int counter = 0;

  Future<void> increment() async {
    counter = counter + 1;
  }

  @observable
  String email = "";

  @action
  void setEmail(String text) => email = text;

  @observable
  String password = "";

  @action
  void setPassword(String text) => password = text;

  @computed
  bool get finish => email.isNotEmpty && password.isNotEmpty;

  @observable
  bool loading = false;

  @observable
  dynamic result = false;

  @action
  Future signInWithEmailAndPassword(context) async {
    if (finish) {
      loading = true;
      final user = UserModel();

      user.email = email.trim();
      user.password = password.trim();

      result = await LoginRepository().loginUser(user);
      loading = false;

      if (result != true) {
        // return [ AlertType.info, "ATENÇÃO", result];
        alertDialog(context, AlertType.info, "ATENÇÃO", result);
      } else {
        Modular.to.navigate('/home');
        await appController.recoverUserData();
      }
    } else {
      alertDialog(context, AlertType.info, "ATENÇÃO",
          "Preencha todos os campos para prosseguirmos!");
    }
  }
}
