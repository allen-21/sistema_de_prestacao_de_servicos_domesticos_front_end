import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/servicos/servicos_view_model.dart';
import 'view/inicialView/tela_boas_vindas.dart';

import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ServicosViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TelaBoasVindas(),
      ),
    ),
  );
}
