import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Metodo per creare o aggiornare un documento
  Future<void> createOrUpdate(String collectionPath, String docId, Map<String, dynamic> data) async {
    await _db.collection(collectionPath).doc(docId).set(data, SetOptions(merge: true));
  }

  // Metodo per leggere un singolo documento
  Future<DocumentSnapshot> readDocument(String collectionPath, String docId) async {
    return await _db.collection(collectionPath).doc(docId).get();
  }

  // Metodo per leggere tutti i documenti di una collezione
  Future<QuerySnapshot> readCollection(String collectionPath) async {
    return await _db.collection(collectionPath).get();
  }

  // Metodo per aggiornare un documento esistente
  Future<void> updateDocument(String collectionPath, String docId, Map<String, dynamic> data) async {
    await _db.collection(collectionPath).doc(docId).update(data);
  }

  // Metodo per eliminare un documento
  Future<void> deleteDocument(String collectionPath, String docId) async {
    await _db.collection(collectionPath).doc(docId).delete();
  }
}