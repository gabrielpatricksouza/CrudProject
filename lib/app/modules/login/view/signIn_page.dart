import 'package:crud_project/app/modules/login/store/login_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final LoginStore _controllerLogin = Modular.get();

  final firebaseAuth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool hidepassword = true;

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
        body: SingleChildScrollView(
          child: Observer(
            builder: (_) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/login.svg', height: size.height * 0.30),
                  const SizedBox(height: 25,),
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
                      cursorColor: const Color(0xFF6F35A5),
                      controller: _controllerLogin.emailController,
                      onChanged: _controllerLogin.setEmail,
                    ),
                  ),
                  Observer(
                    builder: (_) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.0),
                      child: TextFormField(
                        obscureText: hidepassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        cursorColor: const Color(0xFF6F35A5),
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
                                hidepassword == true
                                    ? Icons.remove_red_eye
                                    : Icons.close,
                                color: const Color(0xFF6F35A5),
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Senha",
                        ),
                        controller: _controllerLogin.passwordController,
                        onChanged: _controllerLogin.setPassword,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: size.width * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: TextButton(
                        onPressed: () {
                          _controllerLogin.signInWithEmailAndPassword(context);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          primary: Colors.white,
                          backgroundColor: const Color(0xFF6F35A5),
                        ),
                        child: const Text('ENTRAR'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
