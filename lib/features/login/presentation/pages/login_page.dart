
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
            toolbarHeight: 75,
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
              padding: const EdgeInsets.only(left: 6, bottom: 8),
              child: userController.logoUrl.isEmpty
                  ? SizedBox(width: 20)
                  : Image.network(userController.logoUrl),
            ),
            // Icone aggiunte per comodità, non fanno parte dell'app
            actions: [
              IconButton(
                // Icona per skippare il login
                onPressed: () {
                  userController.clearForm(userController, _loginFormKey);
                  Get.toNamed(Routes.HOME);
                } ,
                icon: Icon(Icons.access_time_filled_outlined,color: Colors.white,),
                iconSize: 30,
              ),
              IconButton(
                 // Icona per andare alla pagina amministratore
                  onPressed: () {
                    userController.clearForm(userController, _loginFormKey);
                    Get.toNamed(Routes.ADMINISTRATOR);
                  },
                  icon: Icon(Icons.key_rounded, color: Colors.white),
                iconSize: 30,
              ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 6),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Accedi con le tue credenziali",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Container(
                        height: 305,
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                              validator: (value) {
                                if(!(userController.regexEmailPattern.hasMatch(value!))) {
                                  return "Inserisci una email valida";
                                }
                                return null;
                              },
                            ),
                          SizedBox(height: 28),
                              TextFormField(
                                controller: userController.passwordController,
                                decoration: InputDecoration(
                                  labelText: "Inserisci la tua password",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      userController.setShowPass(!(userController.getShowPass()));
                                    },
                                    icon: Icon(Icons.abc_outlined),
                                  ),
                                ),
                                obscureText: userController.getShowPass(),
                                validator: (value) {
                                  if (!(userController.regexPassPattern.hasMatch(value!))) {
                                    return "Inserisci una password valida";
                                  }
                                  return null;
                                  },
                              ),
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 65),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                )
                            ),
                            onPressed: () async {
                              if(_loginFormKey.currentState!.validate()){
                               await userController.loginWithCondition(
                                    userController,
                                    userController.emailController.text,
                                    userController.passwordController.text
                                );
                              }
                            },
                            child: Text(
                              "ACCEDI",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                            ]
                    )
                   ),
                  ),
                  Text("Non sei ancora registrato?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                      userController.clearForm(userController, _loginFormKey);
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
