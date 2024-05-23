import 'package:flutter/material.dart';

class TelaConversa extends StatelessWidget {
  const TelaConversa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
      ),
      body: const Center(
        child: Text('Conteúdo da Lista de Pedidos'),
      ),
    );
  }
}