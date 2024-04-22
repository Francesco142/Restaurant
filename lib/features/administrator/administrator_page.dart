import 'package:flutter/material.dart';
import 'package:ordini_ristorante/utils/firestore_helper.dart';

import 'datas.dart';

class AdministratorPage extends StatefulWidget {
  const AdministratorPage({super.key});

  @override
  State<AdministratorPage> createState() => _AdministratorPageState();
}

class _AdministratorPageState extends State<AdministratorPage> {

  FirestoreHelper prova = FirestoreHelper();

  Datas mock = Datas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina amministratore"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async{

                  // DEVO PRIMA AGGIUNGERE LE IMMAGINI SULLO STORE

                  mock.dishesData.forEach((key, value)  {

                    print("${key.toString()} & value $value");

                    prova.createOrUpdate('dishes', key, value);

                  });
                },
                child: Text("Aggiungi tutti i piatti su Firease")
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: ()  {

                  prova.deleteAllDocuments('dishes');

                },
                child: Text("Elimina tutti i piatti su Firease")
            ),
          ],
        ),
      ),
    );
  }
}
