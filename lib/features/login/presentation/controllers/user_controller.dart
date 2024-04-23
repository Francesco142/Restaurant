import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/domain/repositories/user_repo.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/firestore_helper.dart';

class UserController extends GetxController{

  final UserRepository userRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController regMailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController telefono = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController cognome = TextEditingController();

  FirestoreHelper firestoreHelper = FirestoreHelper();

  bool showPass = true;

  String logoUrl = "";

  // Facilitare il cambio di layout pagina senza cambiare tutto ogni volta
  double sizeBoxHeight = 20;
  double sizeContainerTextField = 85;

  // Almeno una maiuscola, una minuscola, @ e . e 2 lettere dopo il punto, in questo ordine
  RegExp regexEmailPattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // Almeno una maiuscola, una minuscola, un numero
  RegExp regexPassPattern = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{5,}$');

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
      Get.toNamed(Routes.HOME);
    }

  }

  Future<bool> signUpWithCondition(UserController userController, String email, String password) async {

    User? user = await userController.signUp(email, password);

    if (user == null) {
      print("errore di registrazione, non andato");
      return false;
    } else {
      print("User successfuly created");
      userController.emailController.clear();
      userController.passwordController.clear();
      return true;
      // Get.toNamed(Routes.LOGIN);
    }

  }

  // Registrazione nel database
  Future<void> registerUser(Map<String, dynamic> userData, GlobalKey<FormState> formKey) async {

    bool userExists = await firestoreHelper.isUserExists(userData['email']);

    if (userExists) {
      print("${userData['email']} già esiste");

      // Mostra uno Snackbar per notificare che l'utente esiste già
      Get.snackbar(
        backgroundColor: Colors.red,
        colorText: Colors.black,
        "Utente esistente",
        "${userData['email']} già esiste",
        duration: Duration(seconds: 3),
      );
    } else {
      if (await formKey.currentState!.validate()) {
        // Registra l'utente utilizzando il metodo signUpWithCondition
        bool success = await signUpWithCondition(
          this,
          userData['email'],
          userData['password'],
        );

        if (success) {
          // Se la registrazione è riuscita, crea o aggiorna i dati dell'utente nel database Firestore
          firestoreHelper.createOrUpdate("users", userData['email'], userData);

          // Cancella il modulo di registrazione e mostra uno Snackbar di successo
          clearSignupForm(this, formKey);

          Get.back();

          Get.snackbar(
            backgroundColor: Colors.lightGreen,
            colorText: Colors.black,
            "Registrazione riuscita",
            "Utente registrato con successo!",
            duration: Duration(seconds: 3),
          );
        } else {
          print("Errore durante la registrazione");
        }
      }
    }
  }


  void clearForm(UserController userController, GlobalKey<FormState> formKey) {
    formKey.currentState!.reset();
    userController.emailController.clear();
    userController.passwordController.clear();
  }


  void clearSignupForm(UserController userController, GlobalKey<FormState> formKey) {
    formKey.currentState!.reset();
    userController.regMailController.clear();
    userController.regPasswordController.clear();
    userController.telefono.clear();
    userController.nome.clear();
    userController.cognome.clear();
  }


  @override
  void onInit() async{

    logoUrl = await getLogoUrl();

    update();

    super.onInit();

  }


  Future<String> getLogoUrl() async {

    Reference logo = FirebaseStorage.instance.ref();
    var imageRef = logo.child("logo.png");
    String logoUrl = await imageRef.getDownloadURL();
    return logoUrl;

  }




}