
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

  // Metodo per eliminare tutti i documenti di una raccolta
  Future<void> deleteAllDocuments(String collectionPath) async {

    var querySnapshot = await _db.collection(collectionPath).get();

    // Itera su tutti i documenti ed eliminali
    for (var document in querySnapshot.docs) {
      await document.reference.delete();
    }

  }

  // Metodo per controllare se esiste un documento con la stessa email

  Future<bool> isUserExists(String email) async {

    // Leggi la collezione 'users' da Firestore
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection("users").get();

    // Itera su tutti i documenti per controllare se esiste un utente con la stessa email
    for (QueryDocumentSnapshot userDocument in usersSnapshot.docs) {

      // Ottieni i dati del documento
      Map<String, dynamic> userData = userDocument.data() as Map<String, dynamic>;

      // Controlla se il campo 'email' nel documento corrente è uguale all'email fornita
      if (userData['email'] == email) {
        return true;
      }
    }

    return false;
  }


}