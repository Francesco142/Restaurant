import 'package:get/get.dart';
import 'package:ordini_ristorante/features/cart/bindings/cart_binding.dart';

import '../../cart/data/repositiories_impl/cart_repo_impl.dart';
import '../../cart/presentation/controllers/cart_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    CartBinding().dependencies();

  }
}
