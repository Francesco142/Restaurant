
import 'package:get/get.dart';

import '../../../../utils/firestore_helper.dart';
import '../../datas.dart';

class AdministratorController extends GetxController{

  FirestoreHelper helperCreate = FirestoreHelper();

  Datas mock = Datas();

  void addDatasFirestore() {
    mock.dishesData.forEach((key, value)  {

      print("${key.toString()} & value $value");

      helperCreate.createOrUpdate('dishes', key, value);

    });
  }

  void deleteAllDocuments(String colletionPath){

   helperCreate.deleteAllDocuments(colletionPath);

  }


}