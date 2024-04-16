import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MenuDatasource {

  final CollectionReference dishes =
  FirebaseFirestore.instance.collection('dishes');

  Stream<QuerySnapshot> getDishes() {
    final dishesStream = dishes.snapshots();

    return dishesStream;
  }

  Future<String> getLogoUrl() async{

    Reference logo = FirebaseStorage.instance.ref();

    var imageRef = logo.child("logo.png");

    return await imageRef.getDownloadURL();

  }

}
