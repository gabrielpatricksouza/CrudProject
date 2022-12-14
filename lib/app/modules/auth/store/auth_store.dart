import 'package:crud_project/app/modules/auth/service/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthSevice _authSevice = AuthSevice();

  ///Verificar usuário logado:
  verifyLoggedUser() {
    final loggedUser = _authSevice.checkCurrentUser();
    if (loggedUser) {
      //TODO: Revisar
      ///Se os dados são na home, essa função tem que chamar na home
      // _appController.recoverUserData();
      Modular.to.navigate('/home');
    } else {
      Modular.to.navigate('/login');
    }
  }
}
