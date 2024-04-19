import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/domain/repositories/user_repo.dart';

import '../../../../routes/routes.dart';

class UserController extends GetxController{

  final UserRepository userRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPass = true;

  UserController(this.userRepository);

  void setShowPass(bool pass) {
    showPass = pass;
    update();
  }

  bool getShowPass() {
    return showPass;
  }

  Future<User?> signUp(String email, String password) async{

    return userRepository.signUp(email, password);

  }

  Future<User?> signIn(String email, String password) async{

    return userRepository.signIn(email, password);

  }

  Future<void> loginWithCondition(UserController userController, String email, String password) async {

    User? user = await userController.signIn(email, password);

    if(user == null){
      print("Utente non esiste");
    }
    else{
      emailController.clear();
      passwordController.clear();
      Get.toNamed(Routes.MENU);
    }

  }

  Future<void> signUpWithCondition(UserController userController, String email, String password) async {

    User? user = await userController.signUp(email, password);

    if (user == null) {
      print("errore di registrazione, non andato");
    } else {
      print("User successfuly created");
      Get.back();
    }
  }

  void clearForm(UserController userController, GlobalKey<FormState> formKey) {
    formKey.currentState!.reset();
    userController.emailController.clear();
    userController.passwordController.clear();
  }




}