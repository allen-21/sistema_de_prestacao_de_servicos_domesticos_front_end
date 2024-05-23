import 'package:flutter/material.dart';

class AdminWelcomeScreen extends StatelessWidget {
  final String token;

  const AdminWelcomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, Administrador'),
      ),
      body: Center(
        child: Text('Token: $token'),
      ),
    );
  }
}