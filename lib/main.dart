import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/bindings/bindings.dart';
import 'package:ihdplm_new/screens/forgetpass.dart';
import 'package:ihdplm_new/screens/login.dart';
import 'package:ihdplm_new/screens/resetpass.dart';
import 'package:ihdplm_new/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ihdplm_new/auth/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// navigator key
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'IHDPLM_NEW',
      initialBinding: MyBindings(),
      home: WidgetTree(),
    );
  }
}
