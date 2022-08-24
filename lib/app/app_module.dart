import 'package:crud_project/app/app_controller.dart';
import 'package:crud_project/app/modules/auth/module/auth_module.dart';
import 'package:crud_project/app/modules/login/module/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/home/module/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/login', module: LoginModule()),
  ];
}
