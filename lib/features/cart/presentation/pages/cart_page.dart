import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../data/models/cart_item.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {

  const CartPage({super.key}); 

  @override
  Widget build(BuildContext context) {

    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrello'),
      ),
      body: Column(
        children: [
          // Expanded per riempire tutto lo schermo senza dare una grandezza fissa come container
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: cartController.getCartItems().length,
                itemBuilder: (context, index) {
                  CartItem cartItem = cartController.getCartItems()[index];
                  return ListTile(
                    title: Text( cartItem.quantity.toString() + "x " + cartItem.dish.title),
                    subtitle: Text('\$${cartItem.dish.price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        cartController.removeFromCart(cartItem);
                      },
                    ),
                  );
                },
              );
            }),
          ),
          ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                    titlePadding: EdgeInsets.only(left: 40, right: 40, top: 30),
                    content: Text(""),
                    title: "Sei sicuro di voler ordinare?",
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("No", style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                          onPressed: () {
                            // Fai ordine
                            Get.back();
                          },
                          child: Text("Si", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ]
                );
              }, 
              child: Text("Ordina")
          )
        ],
      ),
    );
  }
}
