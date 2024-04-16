
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/data/datasources/user_datasource.dart';
import 'package:ordini_ristorante/features/login/domain/repositories/user_repo.dart';
import 'package:ordini_ristorante/features/login/presentation/controllers/user_controller.dart';

import '../data/repositiories_impl/user_repo_impl.dart';

class UserBinding extends Bindings{

  @override
  void dependencies() {

    Get.lazyPut<UserDatasource>( () => UserDatasource());

    Get.lazyPut<UserRepository>( () => UserRepositoryImpl(Get.find<UserDatasource>()) );

    Get.lazyPut<UserController>( () => UserController(Get.find<UserRepository>()));


  }

}