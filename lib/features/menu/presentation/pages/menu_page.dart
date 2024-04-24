import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:ordini_ristorante/features/login/presentation/pages/login_page.dart';
import 'package:ordini_ristorante/features/menu/presentation/controllers/menu_restaurant_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/cart/presentation/controllers/cart_controller.dart';
import 'package:ordini_ristorante/features/menu/data/models/dish.dart';
import 'package:ordini_ristorante/features/menu/presentation/pages/detail_page.dart';
import 'package:ordini_ristorante/routes/routes.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuRestaurantController>(
        builder: (menuController) {
      return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            toolbarHeight: 75,
            title: const Text(
              "Francesco's Restaurant",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 22
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: Padding(
              padding: EdgeInsets.only(left: 6, bottom: 8),
              child: menuController.logoUrl.isEmpty
                  ? SizedBox(width: 20)
                  : Image.network(menuController.logoUrl),
            ),
            actions: [
              IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                onPressed: () {
                  Get.toNamed(Routes.CART);
                },
              ),
              IconButton(
                iconSize: 30.0,
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: menuController.streamDishes(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if (snapshot.hasData) {

                print(menuController.selectedCategory.value);

                Map<String, int> categoriesCount = menuController.countCategories(snapshot.data!.docs);

                List<Dish> dishItems = menuController.dishFilterItems(snapshot, menuController.selectedCategory.value);

                cartController.initializeQuantity(dishItems);

                return Column(
                  children: [
                    Container(
                      height: 100,
                      width: 380,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoriesCount.length,
                        itemBuilder: (context, index) {
                          String category = categoriesCount.keys.toList()[index];
                          return InkWell(
                             onTap: () {
                               menuController.setSelectedCategory(category);
                             },
                            child: Container(
                                alignment: Alignment.center,
                                width: 110,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: category == menuController.selectedCategory.value ? Theme.of(context).primaryColor : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(3, 3),
                                          color: Colors.grey,
                                          blurRadius: 6),
                                    ]),
                                child: Text(
                                  category.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: category.length > 8 ? 13.5 : 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                )),
                          );

                        },
                      ),
                    ),
                    Text(
                      menuController.getSelectedCategory().toUpperCase(),
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                            itemCount: dishItems.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 16,
                                childAspectRatio: 9 / 18),
                            itemBuilder: (BuildContext context, int index) {

                              Dish dish = dishItems[index];

                              return Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(3, 3),
                                            color: Colors.grey,
                                            blurRadius: 6),
                                      ],
                                      color: Colors.white
                                  ),
                                  child: Material(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(DetailsPage(
                                          pictureUrl: dish.pictureUrl,
                                          title: dish.title,
                                          ingredients: dish.ingredients,
                                          price: dish.price,
                                        ));
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            dish.pictureUrl,
                                            height: 120,
                                            errorBuilder: (context, error, stackTrace) {
                                              return CircularProgressIndicator(strokeWidth: 2);
                                            },
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Text(
                                                dish.title,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Text(
                                                "\$" + dish.price.toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      cartController
                                                          .decreaseQuantity(index);
                                                    },
                                                    icon: Icon(Icons.remove_circle)),
                                                 Obx(() =>
                                                     Text(
                                                   cartController.getQuantity()[index].toString(),
                                                   style: TextStyle(fontSize: 21),
                                                 ),
                                               ),
                                                IconButton(
                                                    onPressed: () {
                                                      cartController
                                                          .increaseQuantity(index);
                                                    },
                                                    icon: Icon(Icons.add_circle)),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                cartController.addToCart(dish,
                                                    cartController.getQuantity()[index]);
                                              },
                                              child: Text("Aggiungi")),
                                        ],
                                      ),
                                    ),
                                  ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
      );
    });
  }
}
