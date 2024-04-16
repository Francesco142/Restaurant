import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ordini_ristorante/routes/app_pages.dart';
import 'package:ordini_ristorante/routes/routes.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
    );
  }
}

