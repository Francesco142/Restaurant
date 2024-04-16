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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: const Text(
              "Francesco's Restaurant",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 27),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 6),
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
          ),
          body: Column(
            children: [
              // Image.asset(
              //   "assets/login.png",
              // ),
              Text(
                "Benvenuti nella pagina di login ",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              Form(
                key: _formKey,
                child: Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                        children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "Inserisci la tua mail",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email)
                          ),
                        ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: passwordController,
                        decoration:InputDecoration(
                            labelText: "Inserisci la tua password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password)
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0) )),
                        onPressed: () async {

                          String email = emailController.text;
                          String password = passwordController.text;

                          User? user = await userController.signIn(email, password);

                          if (user != null) {
                            print("User logged");
                            Get.toNamed(Routes.MENU);
                          } else {
                            print("errore");
                          }

                        },
                        child: Text("Login"),
                      )
                    ])),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0) )),
                onPressed: () {
                  Get.toNamed(Routes.SIGNUP);
                },
                child:
                Text(
                  "Crea nuovo account",
                  style: TextStyle(fontSize: 18),
                )
              ),
              // prova per skippare il login
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.MENU);
                },
                child: Text("SKIP"),)
            ],
          ),
        );
      }
    );
  }

  void signIn(UserController login) async {

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await login.signIn(email, password);

    if (user != null) {
      print("User logged");
      Get.toNamed(Routes.MENU);
    } else {
      print("errore");
    }
  }


}
