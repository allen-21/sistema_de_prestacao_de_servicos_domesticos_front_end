import 'package:flutter/material.dart';

class PerfilCliente extends StatelessWidget {
  final String token;

  const PerfilCliente({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, Cliente'),
      ),
      body: Center(
        child: Text('Token: $token'),
      ),
    );
  }
}