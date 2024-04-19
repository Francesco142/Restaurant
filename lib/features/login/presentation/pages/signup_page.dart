
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/data/repositiories_impl/user_repo_impl.dart';

import '../../../../routes/routes.dart';
import '../controllers/user_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final TextEditingController regMailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController telefono = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController cognome = TextEditingController();

  final _signupFormKey = GlobalKey<FormState>();

  double sizeBoxHeight = 20;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        return Scaffold(
          // Aggiunto per evitare l'overflow della tastiera
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackButton(
                color: Colors.white
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
              margin: EdgeInsets.only( left: 38, right: 38, bottom: 175, top: 65),
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
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nome,
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 10.0,
                                      ),
                                    ),
                                    prefixIcon: Icon(Icons.account_circle_rounded),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // Spazio tra i campi "Nome" e "Cognome"
                              Expanded(
                                child: TextFormField(
                                  controller: cognome,
                                  decoration: InputDecoration(
                                    labelText: "Cognome",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 10.0,
                                      ),
                                    ),
                                    prefixIcon: Icon(Icons.account_circle_rounded),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: sizeBoxHeight),
                          TextFormField(
                            controller: telefono,
                            decoration: InputDecoration(
                              labelText: "Telefono",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 10.0,
                                ),
                              ),
                              prefixIcon: Icon(Icons.add_call),
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          TextFormField(
                            controller: regMailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 10.0,
                                ),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          TextFormField(
                            controller: regPasswordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.password),
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () {
                              userController.signUpWithCondition(
                                  userController,
                                  regMailController.text,
                                  regPasswordController.text
                              );
                            },
                            child: Text(
                              "REGISTRATI",
                              style: TextStyle(fontSize: 18),
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
