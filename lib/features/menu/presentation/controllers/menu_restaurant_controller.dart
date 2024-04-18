import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ordini_ristorante/features/menu/domain/repositories/menu_repo.dart';

import '../../data/models/dish.dart';

class MenuRestaurantController extends GetxController{

  final MenuRepository menuRepository;

  RxString selectedCategory = "antipasti".obs;

  String logoUrl = "";

  MenuRestaurantController(this.menuRepository);

  String getSelectedCategory(){
    return selectedCategory.value;
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    update();
  }

  @override
  void onInit() async{

    logoUrl = await menuRepository.getLogoUrl();

    update();

    super.onInit();

  }

  Stream<QuerySnapshot> streamDishes(){

    return menuRepository.getDishes();

  }

  List<Dish> dishFilterItems(AsyncSnapshot<QuerySnapshot> snapshot, String selectedCategory){

    return menuRepository.dishFilterItems(snapshot, selectedCategory);

  }

  Map<String, int> countCategories(List<DocumentSnapshot> documents){

    return menuRepository.countCategories(documents);

  }

}