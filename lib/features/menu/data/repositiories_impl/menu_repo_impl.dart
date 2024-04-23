import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:ordini_ristorante/features/menu/data/datasources/menu_datasource.dart';
import 'package:ordini_ristorante/features/menu/data/models/dish.dart';
import 'package:ordini_ristorante/features/menu/domain/repositories/menu_repo.dart';

class MenuRepositoryImpl extends MenuRepository{

  final MenuDatasource menuDatasource;

  MenuRepositoryImpl(this.menuDatasource);

  @override
  Stream<QuerySnapshot> getDishes() {

    return menuDatasource.getDishes();

  }

  @override
  Future<String> getLogoUrl() async{

    return await menuDatasource.getLogoUrl();
  }

  // Contare il numero di elementi di ogni categoria,
  // per inserirlo nell'itemCount della grid
  @override
  Map<String, int> countCategories(List<DocumentSnapshot> documents) {
    Map<String, int> categoriesCount = {};
    for (DocumentSnapshot document in documents) {
      String category = document['category'];
      categoriesCount[category] = (categoriesCount[category] ?? 0) + 1;
    }
    return categoriesCount;
  }

  // Passo la categoria nell'indice in quel momento
  @override
  List<Dish> dishFilterItems(AsyncSnapshot<QuerySnapshot> snapshot, String selectedCategory) {

    return snapshot.data!.docs
        .map((DocumentSnapshot document) =>
        Dish.fromSnapshot(document))
        .where((dish) => dish.category == selectedCategory)
        .toList();

  }

  // Filtro categoria senza funzionale

  //List<Dish> dishItems = snapshot.data!.docs.map(
  // (DocumentSnapshot document) => Dish.fromSnapshot(document)).toList();
  //
  // List<Dish> filteredDishes = [];
  //
  // for (Dish dish in dishItems) {
  //   if (dish.category == selectedCategory) {
  //     filteredDishes.add(dish);
  //   }
  // }



}
