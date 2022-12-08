import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/src/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihdplm_new/src/authentication/auth/auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userId() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton.icon(
      onPressed: () => FirebaseAuth.instance.signOut(),
      label: const Text('Sign Out', style: TextStyle(fontSize: 24)),
      icon: Icon(Icons.arrow_back, size: 32),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _userId(),
              SizedBox(height: 20),
              _signOutButton(),
            ]),
      ),
    );
  }
}
