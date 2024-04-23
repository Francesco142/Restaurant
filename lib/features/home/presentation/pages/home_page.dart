
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/routes/routes.dart';

import '../../../cart/data/repositiories_impl/cart_repo_impl.dart';
import '../../../cart/presentation/controllers/cart_controller.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // non utilizzo l'istanza ma mi permette di mantenere la peristenza del carrello fra le varie schermate
  final CartController _cartController = Get.put(CartController(CartRepoImpl()));

  String logoUrl = "https://firebasestorage.googleapis.com/v0/b/ristorante-c94d2.appspot.com/o/logo.png?alt=media&token=feb755c3-97ba-4809-9b9b-a35ecdfbc6ed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 6, bottom: 8),
          child: Image.network(logoUrl)
        ),
        toolbarHeight: 75,
        title: Text(
          "Francesco's Restaurant",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 22
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Get.toNamed(Routes.USER);
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Get.offNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 55,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          onTap: (value) {
            value == 0 ? Get.toNamed(Routes.MENU) : Get.toNamed(Routes.CART);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: "Menu"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Carrello"),
        ],
      ),
    );
  }
}
