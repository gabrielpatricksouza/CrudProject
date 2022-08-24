import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:crud_project/app/model/user.dart';
import 'package:crud_project/app/modules/login/repository/login_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

final nameController = TextEditingController();
final emailController = TextEditingController();
final cpfController = TextEditingController();
final passwordController = TextEditingController();
final telController = TextEditingController();

///Validar campos:
abstract class _RegisterStore with Store {
  List validateFields(UserModel model) {
    if (model.name.isEmpty) {
      return [AlertType.info, "Atenção", "Insira o seu nome!"];
    } else if (model.email.isEmpty) {
      return [AlertType.info, "Atenção", "Insira o seu e-mail!"];
    } else if (EmailValidator.validate(model.email) == false) {
      return [AlertType.info, "Atenção", "E-mail é inválido!"];
    } else if (CPFValidator.isValid(model.cpf) == false) {
      return [AlertType.info, "Atenção", "CPF inválido!"];
    } else if (model.phone.isEmpty) {
      return [AlertType.info, "Atenção", "Insira seu telefone"];
    } else if (model.phone.length < 13) {
      return [AlertType.info, "Atenção", "Número de telefone inválido!"];
    } else if (model.maritalStatus.isEmpty) {
      return [AlertType.info, "Atenção", "Selecione seu estado civil!"];
    } else if (model.genre.isEmpty) {
      return [AlertType.info, "Atenção", "Selecione seu gênero sexual!"];
    } else if (model.password.isEmpty) {
      return [AlertType.info, "Atenção", "Insira sua senha!"];
    } else if (model.password.length < 7) {
      return [AlertType.info, "Atenção", "Sua senha tem menos de 7 caracteres"];
    }
    return [true];
  }


  Future<bool> signUpUser(UserModel model) async {
    final repository = LoginRepository();
    final user = await repository.createAccount(model);
    if (user != null) {
      return await repository.registerUser(model, user);
    } else {
      return false;
    }
  }
}
