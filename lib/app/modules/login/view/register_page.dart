import 'dart:io';
import 'package:crud_project/app/modules/login/store/register_store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:crud_project/app/model/user.dart';
import 'package:crud_project/app/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? imageFile;

  final RegisterStore controllerRegister = Modular.get();
  final FirebaseStorage storage = FirebaseStorage.instance;

  String groupValueSexo = "";
  String groupValue = "";
  String url = "";
  bool loading = false;
  bool hidepassword = true;

  Future<XFile?> getImage() async {
    //instância
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }


  Future<void> upload(String path) async {
    // recuperar um arquivo:
    File file = File(path);
    try {
      String ref = 'images/img-{email da pessoa}.jpg';
      final img = storage.ref(ref);
      await img.putFile(file);
      url = await img.getDownloadURL();

    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  pickAndUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      await upload(file.path);
    }
  }


  // Future _pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     File? img = File(image.path);
  //     img = await _cropImage(imageFile: img);
  //     setState(() {
  //       imageFile = img;
  //       Navigator.of(context).pop();
  //     });
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     Navigator.of(context).pop();
  //   }
  // }
  //
  // Future<File?> _cropImage({required File imageFile}) async {
  //   CroppedFile? croppedImage =
  //   await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }
  //
  // void _showSelectPhotoOptions(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(25.0),
  //       ),
  //     ),
  //     builder: (context) => DraggableScrollableSheet(
  //         initialChildSize: 0.28,
  //         maxChildSize: 0.4,
  //         minChildSize: 0.28,
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return SingleChildScrollView(
  //             controller: scrollController,
  //             child: SelectPhotoOptionsScreen(
  //               onTap: _pickImage,
  //             ),
  //           );
  //         }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Modular.to.pushNamed('/login');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF6F35A5),
            ),
          ),
        ),
        body: loading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Color(0xFF6F35A5),
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: GestureDetector(
                    //     behavior: HitTestBehavior.translucent,
                    //     onTap: () {
                    //       _showSelectPhotoOptions(context);
                    //     },
                    //     child: Container(
                    //       height: 150,
                    //       width: 150,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(100),
                    //           border: Border.all(width: 5, color: Colors.white),
                    //           color: Colors.white,
                    //           boxShadow: const [
                    //             BoxShadow(
                    //                 color: Colors.black12,
                    //                 blurRadius: 20,
                    //                 offset: Offset(5, 5))
                    //           ]),
                    //       child: Center(
                    //         child: imageFile == null
                    //             ? Icon(
                    //                 Icons.person,
                    //                 size: 80,
                    //                 color: Colors.grey.shade300,
                    //               )
                    //             : CircleAvatar(
                    //                 backgroundImage: FileImage(imageFile!),
                    //                 radius: 150.0,
                    //               ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: (){ print('pressionado');},
                      child: const Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xFFF1E6FF),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                      ),
                    ),


                    // IconButton(
                    //     onPressed: pickAndUploadImage,
                    //     icon: const Icon(Icons.camera_rounded)),
                    const SizedBox(height: 10,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          //onTap: () => _showSelectPhotoOptions(context),
                          child: const Text(
                            "Adicionar uma foto de perfil",
                            style: TextStyle(
                                color: Color(0xFF6F35A5),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF1E6FF),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFF6F35A5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Nome",
                        ),
                        cursorColor: Colors.deepPurple,
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF1E6FF),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF6F35A5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "E-mail",
                        ),
                        cursorColor: Colors.deepPurple,
                        controller: emailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF1E6FF),
                          prefixIcon: const Icon(
                            Icons.credit_card_rounded,
                            color: Color(0xFF6F35A5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "CPF",
                        ),
                        cursorColor: Colors.deepPurple,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        controller: cpfController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF1E6FF),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Color(0xFF6F35A5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Telefone",
                        ),
                        cursorColor: Colors.deepPurple,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        controller: telController,
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "Estado civil",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF6F35A5)),
                        ),
                        ListTile(
                          title: const Text("Casado(a)"),
                          leading: Radio(
                              value: "Casado(a)",
                              groupValue: groupValue,
                              activeColor: const Color(0xFF6F35A5),
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value as String;
                                });
                              }),
                        ),
                        ListTile(
                          title: const Text("Solteiro(a)"),
                          leading: Radio(
                              value: "Solteiro(a)",
                              groupValue: groupValue,
                              activeColor: const Color(0xFF6F35A5),
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value as String;
                                });
                              }),
                        ),
                        ListTile(
                          title: const Text("Divorciado(a)"),
                          leading: Radio(
                              value: "Divorciado(a)",
                              groupValue: groupValue,
                              activeColor: const Color(0xFF6F35A5),
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value as String;
                                });
                              }),
                        ),
                        ListTile(
                          title: const Text("Viúvo(a)"),
                          leading: Radio(
                              value: "Viúvo(a)",
                              groupValue: groupValue,
                              activeColor: const Color(0xFF6F35A5),
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value as String;
                                });
                              }),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Sexo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF6F35A5)),
                        ),
                        ListTile(
                          title: const Text("Masculino"),
                          leading: Radio(
                              value: "Masculino",
                              groupValue: groupValueSexo,
                              activeColor: const Color(0xFF6F35A5),
                              onChanged: (value) {
                                setState(() {
                                  groupValueSexo = value as String;
                                });
                              }),
                        ),
                        ListTile(
                          title: const Text("Feminino"),
                          leading: Radio(
                              value: "Feminino",
                              groupValue: groupValueSexo,
                              activeColor: const Color(0xFF6F35A5),
                              onChanged: (value) {
                                setState(() {
                                  groupValueSexo = value as String;
                                });
                              }),
                        ),
                        ListTile(
                          title: const Text("Outro(s)"),
                          leading: Radio(
                              value: "Outro(s)",
                              groupValue: groupValueSexo,
                              activeColor: const Color(0xFF6F35A5),
                              onChanged: (value) {
                                setState(() {
                                  groupValueSexo = value as String;
                                });
                              }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.0),
                      child: TextFormField(
                        obscureText: hidepassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF1E6FF),
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: Color(0xFF6F35A5),
                          ),
                          suffixIcon: IconButton(
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                if (hidepassword == true) {
                                  setState(() {
                                    hidepassword = false;
                                  });
                                } else {
                                  setState(() {
                                    hidepassword = true;
                                  });
                                }
                              },
                              icon: Icon(
                                viewPassword
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                color: const Color(0xFF6F35A5),
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Senha",
                        ),
                        cursorColor: Colors.deepPurple,
                        controller: passwordController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      width: size.width * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: TextButton(
                          onPressed: () async {
                            final user = UserModel(
                                name: nameController.text,
                                email: emailController.text,
                                cpf: cpfController.text,
                                phone: telController.text,
                                password: passwordController.text,
                                maritalStatus: groupValue,
                                genre: groupValueSexo);
                            List result =
                                controllerRegister.validateFields(user);

                            if (result.first == true) {
                              setState(() => loading = true);
                              bool result =
                                  await controllerRegister.signUpUser(user);
                              if (result) {
                                Modular.to.navigate('/home');
                                setState(() => loading = false);
                              } else {
                                alertDialog(context, AlertType.error, 'Erro',
                                    'Ocorreu um erro ao criar conta!');
                              }
                            } else {
                              final info = result[0];
                              final title = result[1];
                              final description = result[2];
                              alertDialog(context, info, title, description);
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            primary: Colors.white,
                            backgroundColor: const Color(0xFF6F35A5),
                          ),
                          child: const Text(
                            'REGISTRAR',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
