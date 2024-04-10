
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/data/repositiories_impl/user_repo_impl.dart';

import '../../../../routes/routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final UserRepositoryImpl login = UserRepositoryImpl();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Francesco's Restaurant",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white
          ),
        ),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,

      ),
      body: Column(
        children: [
          Text(
            "Benvenuti nella pagina di registrazione ",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
          Form(
            child: Container(
                margin: EdgeInsets.all(30),
                child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        child: Text("Registra account"),)
                    ]
                )
            ),
          )
        ],
      ),
    );
  }

  void signUp() async {

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await login.signUp(email, password);

    if (user != null) {
      print("User successfuly created");
      Get.back();
    } else {
      print("errore di registrazione, non andato");
    }
  }

}