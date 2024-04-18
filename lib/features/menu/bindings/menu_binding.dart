
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/cart/bindings/cart_binding.dart';
import 'package:ordini_ristorante/features/menu/data/datasources/menu_datasource.dart';
import 'package:ordini_ristorante/features/menu/data/repositiories_impl/menu_repo_impl.dart';
import 'package:ordini_ristorante/features/menu/domain/repositories/menu_repo.dart';
import 'package:ordini_ristorante/features/menu/presentation/controllers/menu_restaurant_controller.dart';

class MenuRestaurantBinding extends Bindings{

  @override
  void dependencies() {

    Get.lazyPut<MenuDatasource>( () => MenuDatasource());

    Get.lazyPut<MenuRepository>( () => MenuRepositoryImpl(Get.find<MenuDatasource>()) );

    Get.lazyPut<MenuRestaurantController>( () => MenuRestaurantController(Get.find<MenuRepository>()));

    CartBinding().dependencies();

  }

}