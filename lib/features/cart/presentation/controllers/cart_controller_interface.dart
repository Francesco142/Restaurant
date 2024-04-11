
import '../../data/models/cart_item.dart';
import '../../../menu/data/models/dish.dart';

abstract class CartControllerInterface {

  void initializeQuantity(List<Dish> dishItems);

  void decreaseQuantity(int index);

  void increaseQuantity(int index);

  void addToCart(Dish dish, int quantit );

  void removeFromCart(CartItem cartItem);

}
