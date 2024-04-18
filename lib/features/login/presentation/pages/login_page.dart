import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/presentation/controllers/user_controller.dart';

import '../../../../routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        return Scaffold(
          // Aggiunto per evitare l'overflow della tastiera
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              "Francesco's Restaurant",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 22
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 6),
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            actions: [
              IconButton(
                // Al momento per skippare il login, poi la usero' per
                // andare alla pagina amministratore per aggiungere piatti
                onPressed: () => Get.toNamed(Routes.MENU),
                icon: Icon(Icons.access_time_filled_outlined, size: 30, color: Colors.white,)
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 38, vertical: 100),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.92), borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    "Accedi con le tue credenziali",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Container(
                        margin: EdgeInsets.all(30),
                        child: Column(
                            children: [
                            TextFormField(
                              controller: userController.emailController,
                              decoration: InputDecoration(
                                  labelText: "Inserisci la tua mail",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 10.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.email)
                              ),
                            ),
                          SizedBox(height: 28),
                          TextFormField(
                            controller: userController.passwordController,
                            decoration:InputDecoration(
                                labelText: "Inserisci la tua password",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.password)
                            ),
                          ),
                              SizedBox(height: 10),
                          TextButton(
                              //Da cambiare
                              onPressed: () => Get.toNamed(Routes.SIGNUP),
                              child: Text(
                                "Hai dimenticato la password?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                ),
                              ),
                          ),
                              SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 65),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                )
                            ),
                            onPressed: () async {

                              await userController.loginWithCondition(
                                  userController,
                                  userController.emailController.text,
                                  userController.passwordController.text
                              );

                            },
                            child: Text(
                              "ACCEDI",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ])),
                  ),
                  Text("Non sei ancora registrato?"),
                  SizedBox(height: 18),
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                         padding: EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                        )
                     ),
                    onPressed: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Text(
                      "REGISTRATI",
                      style: TextStyle(fontSize: 18),
                    )
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
