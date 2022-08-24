import 'package:brasil_fields/brasil_fields.dart';
import 'package:crud_project/app/app_controller.dart';
import 'package:crud_project/app/modules/home/store/home_store.dart';
import 'package:crud_project/app/widgets/input_customized.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeStore controller = Modular.get();
  final appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6F35A5),
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF6F35A5),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Menu",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF6F35A5),
                ),
                title: const Text(
                  'Editar perfil',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF6F35A5),
                  ),
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Color(0xFF6F35A5),
                ),
                title: const Text(
                  'Sair',
                  style: TextStyle(fontSize: 17, color: Color(0xFF6F35A5)),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Modular.to.navigate('/login');
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Observer(
            builder: (context) => controller.loading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          InputCustomized(
                            icon: Icons.person,
                            readOnly: controller.readOnly,
                            hintText: controller.readOnly
                                ? controller.appController.userModel.name
                                : "Nome",
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            controller: controller.nameController,
                          ),
                          const SizedBox(height: 10),
                          InputCustomized(
                            icon: Icons.email_outlined,
                            readOnly: controller.readOnly,
                            hintText: controller.readOnly
                                ? controller.appController.userModel.email
                                : "E-mail",
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
                          ),
                          const SizedBox(height: 10),
                          InputCustomized(
                            icon: Icons.credit_card_rounded,
                            readOnly: true,
                            hintText: controller.appController.userModel.cpf,
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          InputCustomized(
                            icon: Icons.phone,
                            readOnly: controller.readOnly,
                            hintText: controller.readOnly
                                ? controller.appController.userModel.phone
                                : "Telefone",
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            controller: controller.telController,
                          ),
                          const SizedBox(height: 10),
                          InputCustomized(
                            icon: Icons.people,
                            readOnly: true,
                            hintText: controller
                                .appController.userModel.maritalStatus,
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          InputCustomized(
                            icon: Icons.person_outline_outlined,
                            readOnly: true,
                            hintText: controller.appController.userModel.genre,
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.increment();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
