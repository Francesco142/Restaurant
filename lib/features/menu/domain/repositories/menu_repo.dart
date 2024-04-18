
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/dish.dart';

abstract class MenuRepository {

  Stream<QuerySnapshot> getDishes();

  Future<String> getLogoUrl();

  List<Dish> dishFilterItems(AsyncSnapshot<QuerySnapshot> snapshot, String selectedCategory);

  Map<String, int> countCategories(List<DocumentSnapshot> documents);

}
