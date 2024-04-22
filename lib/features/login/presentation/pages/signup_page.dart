
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/data/repositiories_impl/user_repo_impl.dart';
import 'package:ordini_ristorante/utils/firestore_helper.dart';

import '../controllers/user_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  final _signupFormKey = GlobalKey<FormState>();

  FirestoreHelper firestoreHelper = FirestoreHelper();

  double sizeBoxHeight = 20;

  double sizeContainerTextField = 85;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        return Scaffold(
          // Aggiunto per evitare l'overflow della tastiera
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  userController.clearSignupForm(userController, _signupFormKey);
                  Get.back();
                },
            ),
            title: const Text(
              "Francesco's Restaurant",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 22
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 38, right: 38, bottom: 120, top: 35),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.92), borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Registrati con la tua email",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                    key: _signupFormKey,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: userController.nome,
                                    decoration: InputDecoration(
                                      labelText: "Nome",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 10.0,
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.account_circle_rounded),
                                    ),
                                    validator: (value) {

                                      if(value!.length < 3){
                                          return "Non valido";
                                      }
                                      return null;

                                    },
                                  ),
                                ),
                                SizedBox(width: 10), // Spazio tra i campi "Nome" e "Cognome"
                                Expanded(
                                  child: TextFormField(
                                    controller: userController.cognome,
                                    decoration: InputDecoration(
                                      labelText: "Cognome",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 10.0,
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.account_circle_rounded),
                                    ),
                                    validator: (value) {

                                      if(value!.length < 3){
                                        return "Non valido";
                                      }
                                      return null;

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          Container(
                            height: sizeContainerTextField,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: userController.telefono,
                              decoration: InputDecoration(
                                labelText: "Telefono",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10.0,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.add_call),
                              ),
                              validator: (value) {

                                if(value!.length < 3){
                                  return "Non valido";
                                }
                                return null;

                              },
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          Container(
                            height: sizeContainerTextField,
                            child: TextFormField(
                              controller: userController.regMailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10.0,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                // Almeno una maiuscola, una minuscola, @ e . in questo ordine
                                RegExp regexEmailPattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if(!(regexEmailPattern.hasMatch(value!))) {
                                  return "Inserisci una email valida";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          Container(
                            height: sizeContainerTextField,
                            child: TextFormField(
                              controller: userController.regPasswordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.password),
                              ),
                              validator: (value) {
                                // Almeno una maiuscola, una minuscola, un numero
                                RegExp regexPassPattern = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{5,}$');

                                if (!(regexPassPattern.hasMatch(value!))) {
                                  return "Almeno una maiuscola, minuscola, numero";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20 ,horizontal: 50),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              onPressed: () async {

                                Map<String, dynamic> userData = {
                                  'nome': userController.nome.text,
                                  'cognome': userController.cognome.text,
                                  'telefono': userController.telefono.text,
                                  'email': userController.regMailController.text,
                                  'password': userController.regPasswordController.text,
                                };

                                print(await firestoreHelper.isUserExists(userData['email']));

                                bool userExists = await firestoreHelper.isUserExists(userData['email']);

                                if(userExists){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      padding: EdgeInsets.all(35),
                                      content: Text(userData['email'] + " esiste gia ", style: TextStyle(fontSize: 18),),
                                      duration: Duration(seconds: 3), // Durata del messaggio
                                    ),
                                  );

                                }
                                else{

                                  if(_signupFormKey.currentState!.validate()){
                                    userController.signUpWithCondition(
                                      userController,
                                      userController.regMailController.text,
                                      userController.regPasswordController.text,
                                    );

                                    firestoreHelper.createOrUpdate("users", userController.regMailController.text, userData);
                                    userController.clearSignupForm(userController, _signupFormKey);

                                    //Snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        padding: EdgeInsets.all(25),
                                        content: Text('Utente registrato con successo!', style: TextStyle(fontSize: 18),),
                                        duration: Duration(seconds: 3), // Durata del messaggio
                                      ),
                                    );

                                }


                                }

                              },
                              child: Text(
                                "REGISTRATI",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }


}
