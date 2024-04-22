import 'package:get/get.dart';
import 'package:ordini_ristorante/features/cart/domain/repositories/cart_repo.dart';

import '../../data/models/cart_item.dart';
import '../../../menu/data/models/dish.dart';

class CartController extends GetxController {

  final CartRepo cartRepo;

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

}
