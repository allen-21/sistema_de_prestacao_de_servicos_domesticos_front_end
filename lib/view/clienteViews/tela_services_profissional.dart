import 'package:flutter/material.dart';

class ProfissionalDetailScreen extends StatelessWidget {
  final int profissionalId;

  ProfissionalDetailScreen({required this.profissionalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Profissional'),
      ),
      body: Center(
        child: Text(
          'ID do Profissional: $profissionalId',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
