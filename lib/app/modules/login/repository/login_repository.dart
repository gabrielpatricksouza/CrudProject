import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_project/app/core/firebase_const.dart';
import 'package:crud_project/app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginRepository {
  Future<User?> createAccount(UserModel model) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      return user.user;
    } catch (e) {
      debugPrint('Error [login_repository/createAccount]: $e');
      return null;
    }
  }

  Future<bool> registerUser(UserModel model, User user) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseConst.usuarios)
          .doc(user.uid)
          .set({
        "id": user.uid,
        "name": model.name,
        "email": model.email,
        "cpf": model.cpf,
        "telefone": model.phone,
        "estado_civil": model.maritalStatus,
        "sexo": model.genre,
      });
      return true;
    } catch (e) {
      debugPrint('Error [login_repository/registerUser]: $e');
      return false;
    }
  }

  Future loginUser(UserModel model) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: model.email, password: model.password);
      return true;
    } on FirebaseAuthException catch (error) {
      String errorMessage;

      switch (error.code) {
        case "invalid-email":
          errorMessage =
              "Email é inválido!";
          return errorMessage;

        case "wrong-password":
          errorMessage = "Senha errada!";
          return errorMessage;

        case "user-not-found":
          errorMessage = "O usuário não existe.";
          return errorMessage;

        case "too-many-requests":
          errorMessage = "Muitas requisições. Tente mais tarde.";
          return errorMessage;

        case "operation-not-allowed":
          errorMessage = "Login com email e senha não está habilitado.";
          return errorMessage;

        case "email-already-in-use":
          errorMessage =
              "O e-mail fornecido já está em uso por outro usuário. ";
          return errorMessage;

        default:
          errorMessage = "Um erro desconhecido ocorreu.";
          return errorMessage;
      }
    }
  }

  bool checkCurrentUser() {
    User? user = fireAuth.FirebaseAuth.instance.currentUser;
    return user != null ? true : false;
  }
}
