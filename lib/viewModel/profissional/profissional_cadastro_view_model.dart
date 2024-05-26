

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/inicialView/tela_login.dart';

class CadastroViewModel extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Profissional profissional = Profissional(
    nome: '',
    telefone: '',
    endereco: '',
    username: '',
    password: '',
    profissoes: Profissoes.LIMPEZA,
    especialidades: '',
  );
  String? errorMessage;

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var profissionalJson = json.encode({
        'nome': profissional.nome,
        'telefone': profissional.telefone,
        'endereco': profissional.endereco,
        'username': profissional.username,
        'password': profissional.password,
        'profissoes': profissional.profissoes.toString().split('.').last,
        'especialidades': profissional.especialidades,
        'disponibilidade': profissional.disponibilidade,
      });

      var res = await http.post(
        Uri.parse(ApiEndpoints.userRegisterProfissional),
        headers: {'Content-Type': 'application/json'},
        body: profissionalJson,
      );

      if (res.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sucesso'),
              content: Text('Registro bem-sucedido'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (res.statusCode == 400) {
        var errorMessage = res.body;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro de validação'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Erro ao registrar: ${res.body}');
      }
    }
  }
}