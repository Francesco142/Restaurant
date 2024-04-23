

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/user/presentations/controllers/user_page_controller.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

    double heightBox = 30.0;

    bool showOrders = false;

    UserPageController userPageController = Get.put(UserPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      toolbarHeight: 70,
      leading: IconButton(
        iconSize: 30.0,
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        "Il mio account",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 22
        ),
      ),
    ),
    body: Container(
      color: Colors.grey.shade300,
      child: FutureBuilder(
          future: userPageController.getUser(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dati personali", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: heightBox),

                      // EMAIL
                      Text("Email", style: TextStyle(fontSize: 22, color: Colors.grey.shade700, fontWeight: FontWeight.bold)),
                      Text(snapshot.data?["email"], style: TextStyle(fontSize: 20)),
                      SizedBox(height: heightBox),

                      //NOME
                      Text("Nome: ", style: TextStyle(fontSize: 22, color: Colors.grey.shade700, fontWeight: FontWeight.bold)),
                      Text((snapshot.data?["nome"]), style: TextStyle(fontSize: 20),),
                      SizedBox(height: heightBox),

                      //COGNOME
                      Text("Cognome: ", style: TextStyle(fontSize: 22, color: Colors.grey.shade700, fontWeight: FontWeight.bold)),
                      Text((snapshot.data?["cognome"]), style: TextStyle(fontSize: 20),),
                      SizedBox(height: heightBox),

                      // TELEFONO
                      Text("Telefono: ", style: TextStyle(fontSize: 22, color: Colors.grey.shade700, fontWeight: FontWeight.bold)),
                      Text((snapshot.data?["telefono"]), style: TextStyle(fontSize: 20),),
                      SizedBox(height: heightBox),

                      Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              print("Button pressed");
                              print( await userPageController.getOrdersByEmail());

                              setState(() {
                                showOrders = !showOrders;
                              });

                            },
                            child: Text(
                              "MOSTRA ORDINI", style: TextStyle(fontSize: 16),)
                        ),
                      ),
                      SizedBox(height: heightBox),
                      Visibility(
                        visible: showOrders,
                        child: Column(
                          children: [
                            Text("Dettagli ordini",
                                style: TextStyle(fontSize: 30,
                                    fontWeight: FontWeight
                                        .bold)),
                            SizedBox(
                              width: 500,
                              height: 400,
                              child: FutureBuilder(
                                  future: userPageController.getOrdersByEmail(),
                                  builder: (context, snapshot) {
                                         if (snapshot.hasData) {
                                           return ListView.builder(
                                             itemCount: snapshot.data!.length,
                                             itemBuilder: (context, index) {
                                               return Column(
                                                   crossAxisAlignment: CrossAxisAlignment
                                                       .start,
                                                   children: [
                                                     SizedBox(height: heightBox),
                                                     Text("Portate: ${snapshot.data![index]['portate'].toString()}",
                                                         style: TextStyle(fontSize: 20)),
                                                     Text("Totale: ${snapshot.data![index]['totale'].toString()}",
                                                         style: TextStyle(fontSize: 20)),
                                                   ]
                                               );
                                             },
                                           );
                                         }
                                         else{
                                           return Center(child: CircularProgressIndicator());
                                         }
                                  },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }

          },

      ),
    ),
  );
  }
}
