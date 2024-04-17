import 'package:get/get.dart';

import '../../data/models/cart_item.dart';
import '../../../menu/data/models/dish.dart';

class CartController extends GetxController {

  RxList<CartItem> cartItems = <CartItem>[].obs;

  //quantià elemento - 0 +
  RxList<int> quantity = <int>[].obs;

  void initializeQuantity(List<Dish> dishItems) {

    quantity.clear();

    // Inizializza la lista quantity con la stessa lunghezza di dishItems
    if (quantity.isEmpty) {
      for (int i = 0; i < dishItems.length; i++) {
        quantity.add(1);
      }
    }

  }

  void decreaseQuantity(int index) {
    if (quantity[index] > 1) {
      quantity[index]--;
    }
  }

  void increaseQuantity(int index) {
    quantity[index]++;
  }

  void addToCart(Dish dish, int quantity) {

    // Variabile per memorizzare l'elemento trovato
    CartItem? existingCartItem;

    // Ciclo per cercare l'elemento nella lista
    for (var item in cartItems) {
      if (item.dish.title == dish.title) {
        existingCartItem = item;
      }
    }

    // Se la dish è già nel carrello, aumenta la quantità
    if (cartItems.contains(existingCartItem)) {
      existingCartItem!.quantity += quantity;
    } else {
      // Altrimenti, aggiungi un nuovo elemento al carrello
      cartItems.add(CartItem(dish: dish, quantity: quantity));
    }
  }

  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
  }

}
