
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _signupFormKey = GlobalKey<FormState>();

  double sizeBoxHeight = 22;

  @override
  Widget build(BuildContext context) {
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
          margin: EdgeInsets.symmetric(horizontal: 38, vertical: 80),
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
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: "Nome",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10.0,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.account_circle_rounded)
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: "Cognome",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10.0,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.account_circle_rounded)
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: "Telefono",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10.0,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.add_call)
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10.0,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.email)
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
                          TextFormField(
                            controller: passwordController,
                            decoration:InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.password)
                            ),
                          ),
                          SizedBox(height: sizeBoxHeight),
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
                        ]
                    )
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {

    String email = emailController.text;
    String password = passwordController.text;

    UserController login = Get.find<UserController>();

    User? user = await login.signUp(email, password);

    if (user != null) {
      print("User successfuly created");
      Get.back();
    } else {
      print("errore di registrazione, non andato");
    }
  }

}
