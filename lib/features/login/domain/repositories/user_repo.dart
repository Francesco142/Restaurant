
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class UserRepository {

  Future<User?> signUp(String email, String password);

  Future<User?> signIn(String email, String password);

}