import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ordini_ristorante/features/menu/data/datasources/menu_datasource.dart';
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



}
