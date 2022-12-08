import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/src/authentication/screens/forgetpass.dart';
import 'package:ihdplm_new/src/authentication/screens/login.dart';
import 'package:ihdplm_new/src/authentication/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ihdplm_new/src/authentication/auth/widget_tree.dart';
import 'package:ihdplm_new/src/utils/constant.dart';

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
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'IHDPLM_NEW',
      home: WidgetTree(),
    );
  }
}
