
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MenuRepository {

  Stream<QuerySnapshot> getDishes();

  Future<String> getLogoUrl();

}
