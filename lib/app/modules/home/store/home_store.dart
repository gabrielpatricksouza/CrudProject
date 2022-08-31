
import 'package:crud_project/app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../repository/home_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final _repository = HomeRepository();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final telController = TextEditingController();
  final maritalStsController = TextEditingController();
  final genreController = TextEditingController();

  @observable
  bool readOnly = true;

  @action
  changeReadOnly(bool value) => readOnly = value;

  @action
  fetchUserData() {
    nameController.text = userModel.name;
    emailController.text = userModel.email;
    cpfController.text = userModel.cpf;
    telController.text = userModel.phone;
    maritalStsController.text = userModel.maritalStatus;
    genreController.text = userModel.genre;
  }

  //TODO: Como estava antes
  /*
  * fetchUserData() {
    nameController.text = appController.userModel.name;
    emailController.text = appController.userModel.email;
    cpfController.text = appController.userModel.cpf;
    telController.text = appController.userModel.phone;
    maritalStsController.text = appController.userModel.maritalStatus;
    genreController.text = appController.userModel.genre;
  }
  * */


  @observable
  bool loading = false;


  @observable
  UserModel userModel = UserModel();

  @action
  recoverUserData() async {
    bool response = _repository.checkCurrentUser();
    if(response){
      userModel = await _repository.recoverUserData();
    }
  }

  @action
  clearVariables(){
    userModel = UserModel.clean();
  }

  // ///Salvar as alterações:
  // @action
  // _saveChanges(model) async {
  //   loading = true;
  //   bool response;
  //
  //   UserModel model = UserModel();
  //   model.name = nameController.text;
  //   model.phone = telController.text;
  //   model.maritalStatus = maritalStsController.text;
  //   model.genre = genreController.text;
  //
  //   response = await homeStore.updateUserData(model);
  //   if (response == false) {
  //     alertDialog(context, AlertType.info, "ATENÇÃO",
  //         "Ocorreu um erro ao atualizar seu perfil");
  //   } else {
  //     await homeStore.recoverUserData();
  //     fetchUserData();
  //     readOnly = true;
  //   }
  //   loading = false;
  // }

  // ///VALIDAR CAMPOS
  // validateUpdatedFields(UserModel model) {
  //   if (kDebugMode) {
  //     print(EmailValidator.validate(emailController.text));
  //   }
  //   if (model.name.isEmpty) {
  //     return [AlertType.info, "Atenção", "Insira o seu nome!"];
  //   } else if (model.phone.isEmpty) {
  //     return [
  //       AlertType.info,
  //       "Atenção",
  //       "Insira um número de telefone válido para prosseguirmos!"
  //     ];
  //   } else if (model.phone.length < 13) {
  //     return [AlertType.info, "Atenção", "Número de telefone inválido!"];
  //   } else if (model.maritalStatus.isEmpty) {
  //     return [AlertType.info, "Atenção", "Selecione seu estado civil!"];
  //   } else if (model.genre.isEmpty) {
  //     return [AlertType.info, "Atenção", "Selecione seu gênero sexual!"];
  //   } else {
  //     _saveChanges(model);
  //   }
  // }
  // @observable
  // File? imageFile;
  //
  // @action
  // getImage(BuildContext context) async {
  //   await showModalBottomSheet(
  //       context: context,
  //       builder: (context) => ImageSourceSheet(
  //         onImageSelected: (image) {
  //           if(image != null){
  //             imageFile = image;
  //             Navigator.of(context).pop();
  //           }
  //         },
  //       )
  //   );
  // }
}
