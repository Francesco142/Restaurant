import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../data/repositiories_impl/user_repo_impl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserRepositoryImpl login = UserRepositoryImpl();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Francesco's Restaurant",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 4, bottom: 4),
        //   child: Image.asset(
        //     ("assets/logo.png"),
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Text(
            "Benvenuti nella pagina di login ",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
          Form(
            child: Container(
                margin: EdgeInsets.all(30),
                child: Column(children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0) )),
                    onPressed: () {
                      signIn();
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
          )
        ],
      ),
    );
  }

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await login.signIn(email, password);

    if (user != null) {
      print("User logged");
      Get.toNamed(Routes.HOME);
    } else {
      print("errore");
    }
  }


}
