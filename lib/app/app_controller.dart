import 'package:crud_project/app/model/user.dart';
import 'package:crud_project/app/services/dataBase_global.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {

  final DataBaseGlobal _dataBaseGlobal = DataBaseGlobal();

  @observable
  UserModel userModel = UserModel();

  @action
  recoverUserData() async {
    bool response = _dataBaseGlobal.checkCurrentUser();
    if(response){
      userModel = await _dataBaseGlobal.recoverUserData();
    }
  }

  @action
  ///Limpar variáveis:
  clearVariables(){
    userModel = UserModel.clean();
  }
}