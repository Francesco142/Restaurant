import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/utils/firestore_helper.dart';

import '../../data/models/cart_item.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    final CartController cartController = Get.find<CartController>();

    FirestoreHelper firestoreHelper = FirestoreHelper();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Carrello",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 22
          ),
        ),
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
                    subtitle: Text('\$${cartItem.dish.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        cartController.removeFromCart(cartItem);
                      },
                    ),
                  );
                },
              );
            }
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: 500,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    "Totale carrello: \$${cartController.getTotalAmount().toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 21, color: Colors.white),
                  );
                }),
                SizedBox(width: 50),
                ElevatedButton(
                    child: Text("Ordina", style: TextStyle(fontSize: 21),),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
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
                            SizedBox(width: 20),
                            ElevatedButton(
                                onPressed: () {

                                  User? user = FirebaseAuth.instance.currentUser;

                                  // da genrare
                                  String idOrdine = generateOrderName();

                                  Map<String, dynamic> orderData = {
                                    'listaPortate': cartController.getCartItems().map((cartItem) => cartItem.dish.title).toList(),
                                    'totale': cartController.getTotalAmount(),
                                    'email': user!.email,
                                  };

                                  print(orderData.toString());

                                  if(orderData['listaPortate'].isNotEmpty){

                                    // Post DB
                                    firestoreHelper.createOrUpdate('cart', idOrdine, orderData);

                                    // Rimozione piatti acquistati
                                    cartController.removeAllFromCart();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        padding: EdgeInsets.all(25),
                                        content: Text('Ordine andato a buon fine!'),
                                        duration: Duration(seconds: 3), // Durata del messaggio
                                      ),
                                    );
                                  }

                                  // Uscire dal Dialog
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

                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String generateOrderName() {
    // Ottieni il timestamp corrente in millisecondi
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    // Genera un numero casuale compreso tra 1000 e 9999
    int random = Random().nextInt(9000) + 1000;

    // Combina il timestamp e il numero casuale per creare un nome unico per l'ordine
    String orderName = "ordine_$timestamp$random";

    return orderName;
  }

}
