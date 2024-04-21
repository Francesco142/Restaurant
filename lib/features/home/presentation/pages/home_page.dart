
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 6, bottom: 8),
          child: Image.asset(
            "assets/logo.png",
          ),
        ),
        toolbarHeight: 70,
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
            padding: EdgeInsets.all(15),
            iconSize: 40.0,
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // Get.toNamed("");
            },
          ),
          IconButton(
            padding: EdgeInsets.all(15),
            iconSize: 40.0,
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Column(
        children: [

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.amber,
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
