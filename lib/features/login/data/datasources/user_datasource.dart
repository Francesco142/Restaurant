import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ordini_ristorante/features/login/domain/repositories/user_repo.dart';

class UserDatasource {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {


      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return credential.user;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } catch (e) {
      print("Some error occured" );
    }
    return null;
  }

}