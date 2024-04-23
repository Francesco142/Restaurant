
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../data/models/cart_item.dart';
import '../../../menu/data/models/dish.dart';

abstract class CartRepo {

  RxList<CartItem> getCartItems();

  void setCartItems(RxList<CartItem> value);

  RxList<int> getQuantity();

  void setQuantity(RxList<int> value);

  void initializeQuantity(List<Dish> dishItems);

  void decreaseQuantity(int index);

  void increaseQuantity(int index);

  void addToCart(Dish dish, int quantity );

  void removeFromCart(CartItem cartItem);

  void removeAllFromCart();

}
