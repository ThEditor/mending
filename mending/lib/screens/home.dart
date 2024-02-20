import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rehab Home'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child:
            Text(FirebaseAuth.instance.currentUser?.phoneNumber ?? 'No User'),
      ),
    );
  }
}
