import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/cart/domain/repositories/cart_repo.dart';

import '../../../../utils/firestore_helper.dart';
import '../../data/models/cart_item.dart';
import '../../../menu/data/models/dish.dart';

class CartController extends GetxController {

  final CartRepo cartRepo;

  final FirestoreHelper firestoreHelper = FirestoreHelper();

  CartController(this.cartRepo);

  RxList<CartItem> getCartItems() {
    return cartRepo.getCartItems();
  }

  void setCartItems(RxList<CartItem> value) {
    cartRepo.setCartItems(value);
  }

  RxList<int> getQuantity(){
    return cartRepo.getQuantity();
  }

  void setQuantity(RxList<int> value){
    cartRepo.setQuantity(value);
  }

  void initializeQuantity(List<Dish> dishItems) {
    cartRepo.initializeQuantity(dishItems);
  }

  void decreaseQuantity(int index) {
    cartRepo.decreaseQuantity(index);
  }

  void increaseQuantity(int index) {
    cartRepo.increaseQuantity(index);
  }

  void addToCart(Dish dish, int quantity) {
    cartRepo.addToCart(dish, quantity);

  }

  void removeFromCart(CartItem cartItem) {
    cartRepo.removeFromCart(cartItem);
  }

  void removeAllFromCart() {
    cartRepo.removeAllFromCart();
  }


  double getTotalAmount() {
    double total = 0;
    final cartItems = getCartItems();
    for (var cartItem in cartItems) {
      total = total + (cartItem.dish.price * cartItem.quantity);
    }
    return total;
  }

  void createOrder() {
    User? user = FirebaseAuth.instance.currentUser;
    String idOrdine = generateOrderName();
    Map<String, dynamic> orderData = {
      'listaPortate': getCartItems().map((cartItem) => (cartItem.quantity.toString() + "x " + cartItem.dish.title)).toList(),
      'totale': getTotalAmount(),
      'email': user!.email,
    };

    print(orderData.toString());

    if (orderData['listaPortate'].isNotEmpty) {
      // Post DB
      firestoreHelper.createOrUpdate('cart', idOrdine, orderData);


    }

    // Uscire dal Dialog
    Get.back();
    // Show success message

    if(getCartItems().isNotEmpty){
      Get.snackbar(
        backgroundColor: Colors.lightGreen,
        colorText: Colors.black,
        'Ordine completato',
        'Ordine andato a buon fine!',
        duration: Duration(seconds: 2),
      );
    }
    // Rimozione piatti acquistati
    removeAllFromCart();

  }

  String generateOrderName() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int random = Random().nextInt(9000) + 1000;
    return "ordine_$timestamp$random";
  }

}


