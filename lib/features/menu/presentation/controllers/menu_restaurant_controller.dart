import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/menu/domain/repositories/menu_repo.dart';

class MenuRestaurantController extends GetxController{

  final MenuRepository menuRepository;

  MenuRestaurantController(this.menuRepository);

  Stream<QuerySnapshot> streamDishes(){

    return menuRepository.getDishes();

  }

}