import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_project/app/core/firebase_const.dart';
import 'package:crud_project/app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseGlobal {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore dataBase = FirebaseFirestore.instance;

  ///Recuperar dados do usuário:
  Future recoverUserData() async {
    User user = _auth.currentUser!;
    UserModel loginModel = UserModel();
    DocumentSnapshot snapshot =
        await dataBase.collection(FirebaseConst.usuarios).doc(user.uid).get();
    loginModel = UserModel.fromMap(snapshot.data() as Map);
    return loginModel;
  }

  ///Verificar o usuário atual:
  bool checkCurrentUser() {
    User? user = _auth.currentUser;
    return user != null ? true : false;
  }
}
