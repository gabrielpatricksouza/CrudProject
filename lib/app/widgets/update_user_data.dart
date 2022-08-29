import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UpdateUserData extends StatefulWidget {
  const UpdateUserData({Key? key}) : super(key: key);

  @override
  _UpdateUserDataState createState() => _UpdateUserDataState();
}

class _UpdateUserDataState extends State<UpdateUserData> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        backgroundColor: Colors.white,
        elevation: 0,
        //centerTitle: true,
      ),
      body:
      Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print('pressionado');
              },
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              //onTap: () => _showSelectPhotoOptions(context),
              child: const Text(
                "Alterar foto do perfil",
                style: TextStyle(
                    color: Color(0xFF6F35A5),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              width: size.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: TextButton(
                  onPressed: () {
                    Modular.to.navigate('/home');
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    primary: Colors.white,
                    backgroundColor: const Color(0xFF6F35A5),
                  ),
                  child: const Text('Salvar alterações'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
