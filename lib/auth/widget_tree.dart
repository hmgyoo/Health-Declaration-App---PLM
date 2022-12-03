import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihdplm_new/auth/auth.dart';
import 'package:ihdplm_new/auth/authPage.dart';
import 'package:ihdplm_new/screens/login.dart';
import 'package:ihdplm_new/screens/reminders.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          return RemindersScreen();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
