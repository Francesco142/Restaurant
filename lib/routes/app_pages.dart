import 'package:get/get.dart';
import 'package:ordini_ristorante/features/cart/presentation/pages/cart_page.dart';
import 'package:ordini_ristorante/features/login/presentation/pages/login_page.dart';
import 'package:ordini_ristorante/features/login/presentation/pages/signup_page.dart';
import 'package:ordini_ristorante/features/menu/presentation/pages/menu_page.dart';
import 'package:ordini_ristorante/routes/routes.dart';

import '../features/cart/bindings/cart_binding.dart';
import '../features/home/presentation/pages/home_page.dart';


class AppPages{
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      //binding: HomeBinding()
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignupPage(),
      //binding: HomeBinding()
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      //binding: HomeBinding()
    ),
    GetPage(
      name: Routes.MENU,
      page: () => const MenuPage(),
      //binding: HomeBinding()
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartPage(),
      binding: CartBinding()
    ),
  ];
}