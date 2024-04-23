import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPageController extends GetxController {


  Future<Map<String, dynamic>> getUser() async{

    User? firebaseUser = FirebaseAuth.instance.currentUser;

    var userDocument = await FirebaseFirestore.instance.collection("users").doc(firebaseUser?.email).get();

    Map<String, dynamic> userData = userDocument.data() as Map<String, dynamic>;

    return userData;

  }

  Future<List<Map<String, dynamic>>> getOrdersByEmail() async {

    User? firebaseUser = FirebaseAuth.instance.currentUser;

    List<Map<String, dynamic>> orderData = [];

    var cartDocument = await FirebaseFirestore.instance.collection("cart").get();

    for (var doc in cartDocument.docs) {
      if (doc.get('email') == firebaseUser?.email) {
        var order = {
          'portate': doc.get('listaPortate'),
          'totale': doc.get('totale'),
        };
        orderData.add(order);
      }
    }

    return orderData;
  }

}
