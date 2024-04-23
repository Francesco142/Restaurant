import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/administrator/presentations/controllers/administrator_controller.dart';


class AdministratorPage extends StatefulWidget {
  const AdministratorPage({super.key});

  @override
  State<AdministratorPage> createState() => _AdministratorPageState();
}

class _AdministratorPageState extends State<AdministratorPage> {

  AdministratorController adminController = Get.put(AdministratorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Pagina amministratore", style: TextStyle(color: Colors.white),),
        leading: IconButton(icon: Icon(Icons.arrow_back_sharp, color: Colors.white,), onPressed: () {Get.back();},),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async{
                  // DEVO PRIMA AGGIUNGERE LE IMMAGINI SULLO STORE
                  adminController.addDatasFirestore();
                },
                child: Text("Aggiungi tutti i piatti su Firease")
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: ()  {
                  adminController.deleteAllDocuments('dishes');
                },
                child: Text("Elimina tutti i piatti su Firease")
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: ()  {
                  adminController.deleteAllDocuments('cart');
                },
                child: Text("Elimina tutti gli ordini effettuati su firebase")
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: ()  {
                  adminController.deleteAllDocuments('users');
                },
                child: Text("Elimina tutti gli user creati su firebase")
            ),
          ],
        ),
      ),
    );
  }


}
