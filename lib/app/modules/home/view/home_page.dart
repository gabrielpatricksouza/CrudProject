import 'package:brasil_fields/brasil_fields.dart';
import 'package:crud_project/app/modules/home/store/home_store.dart';
import 'package:crud_project/app/widgets/input_customized.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeStore controller = Modular.get();
  bool readOnly = true;

  void onInit() async {
    await controller.recoverUserData();
  }

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Modular.to.navigate('/login');
              },
              icon: const Icon(
                Icons.logout,
                color: Color(0xFF6F35A5),
              ),
            )
          ],
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
                          GestureDetector(
                            onTap: () {
                              print('pressionado');
                            },
                            child: const Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Color(0xFFF1E6FF),
                                child: Image(
                                    image: NetworkImage(
                                        'https://www.otaviomiranda.com.br/wp-content/uploads/2018/07/foto-perfil-2.png')),
                                // child: Icon(
                                //   Icons.person,
                                //   size: 60,
                                //   color: Color(0xFF6F35A5),
                                // ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          InputCustomized(
                            icon: Icons.person,
                            readOnly: readOnly,
                            hintText: controller.readOnly
                                ? controller.userModel.name
                                : "Nome",
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            controller: controller.nameController,
                          ),
                          const SizedBox(height: 15),
                          InputCustomized(
                            icon: Icons.email_outlined,
                            readOnly: readOnly,
                            hintText: controller.readOnly
                                ? controller.userModel.email
                                : "E-mail",
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
                          ),
                          const SizedBox(height: 15),
                          InputCustomized(
                            icon: Icons.credit_card_rounded,
                            readOnly: readOnly,
                            hintText: controller.userModel.cpf,
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15),
                          InputCustomized(
                            icon: Icons.phone,
                            readOnly: readOnly,
                            hintText: controller.readOnly
                                ? controller.userModel.phone
                                : "Telefone",
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            controller: controller.telController,
                          ),
                          const SizedBox(height: 15),
                          InputCustomized(
                            icon: Icons.people,
                            readOnly: readOnly,
                            hintText: controller.userModel.maritalStatus,
                            hintStyle: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15),
                          InputCustomized(
                            icon: Icons.person_outline_outlined,
                            readOnly: readOnly,
                            hintText: controller.userModel.genre,
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
          backgroundColor: const Color(0xFFF1E6FF),
          onPressed: () {
            if (kDebugMode) {
              print('resreser');
            }
            setState(() {
              readOnly = false;
            });
            if (kDebugMode) {
              print(readOnly);
            }
          },
          child: const Icon(Icons.edit_outlined, color: Color(0xFF6F35A5)),
        ),
      ),
    );
  }
}
