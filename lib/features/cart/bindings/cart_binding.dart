import 'package:get/get.dart';
import 'package:ordini_ristorante/features/cart/data/repositiories_impl/cart_repo_impl.dart';
import 'package:ordini_ristorante/features/cart/domain/repositories/cart_repo.dart';
import 'package:ordini_ristorante/features/cart/presentation/controllers/cart_controller.dart';


class CartBinding implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<CartRepo>(() => CartRepoImpl());

    Get.lazyPut<CartController>(() => CartController(Get.find<CartRepo>()));

  }
}