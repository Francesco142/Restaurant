import 'package:cloud_firestore/cloud_firestore.dart';

class MenuRepositoryImpl {

  final CollectionReference dishes =
      FirebaseFirestore.instance.collection('dishes');

  Stream<QuerySnapshot> getDishes() {
    final dishesStream = dishes.snapshots();

    return dishesStream;
  }
}
