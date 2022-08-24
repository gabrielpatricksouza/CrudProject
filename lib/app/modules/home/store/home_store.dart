import 'package:crud_project/app/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {

  final AppController appController = Modular.get();

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
  ///Buscar dados do usuário:
  fetchUserData(){
    nameController.text = appController.userModel.name;
    emailController.text = appController.userModel.email;
    cpfController.text = appController.userModel.cpf;
    telController.text = appController.userModel.phone;
    maritalStsController.text = appController.userModel.maritalStatus;
    genreController.text = appController.userModel.genre;
  }

  @observable
  bool loading = false;


  @observable
  int counter = 0;

  Future<void> increment() async {
    counter = counter + 1;
  }

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