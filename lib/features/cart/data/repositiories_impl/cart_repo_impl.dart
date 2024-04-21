

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ordini_ristorante/features/cart/data/models/cart_item.dart';

import 'package:ordini_ristorante/features/menu/data/models/dish.dart';

import '../../domain/repositories/cart_repo.dart';

import 'package:get/get.dart';

class CartRepoImpl extends CartRepo {

  RxList<CartItem> _cartItems = <CartItem>[].obs;

  //quantià elemento - 0 +
  RxList<int> _quantity = <int>[].obs;

  @override
  RxList<CartItem> getCartItems() {
    return _cartItems;
  }

  @override
  void setCartItems(RxList<CartItem> value) {
    _cartItems = value;
  }

  @override
  RxList<int> getQuantity(){
    return _quantity;
  }

  @override
  void setQuantity(RxList<int> value) {
    _quantity = value;
  }

  @override
  void initializeQuantity(List<Dish> dishItems) {

    _quantity.clear();

    // Inizializza la lista quantity con la stessa lunghezza di dishItems
    if (_quantity.isEmpty) {
      for (int i = 0; i < dishItems.length; i++) {
        _quantity.add(1);
      }
    }

  }

  @override
  void decreaseQuantity(int index) {
    if (_quantity[index] > 1) {
      _quantity[index]--;
    }
  }

  @override
  void increaseQuantity(int index) {
    _quantity[index]++;
  }

  @override
  void addToCart(Dish dish, int quantity) {

    // Variabile per memorizzare l'elemento trovato
    CartItem? existingCartItem;

    // Ciclo per cercare l'elemento nella lista
    for (var item in _cartItems) {
      if (item.dish.title == dish.title) {
        existingCartItem = item;
      }
    }

    // Se la dish è già nel carrello, aumenta la quantità
    if (_cartItems.contains(existingCartItem)) {
      existingCartItem!.quantity += quantity;
    } else {
      // Altrimenti, aggiungi un nuovo elemento al carrello
      _cartItems.add(CartItem(dish: dish, quantity: quantity));
    }
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
  }



}
