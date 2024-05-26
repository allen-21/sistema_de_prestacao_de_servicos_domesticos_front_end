
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/clientemodel.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/inicialView/tela_login.dart';

class CadastroClienteViewModel extends ChangeNotifier {
  Cliente cliente = Cliente(nome: '', telefone: '', endereco: '', username: '', password: '');
  String? errorMessage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var clienteJson = json.encode({
        'nome': cliente.nome,
        'telefone': cliente.telefone,
        'endereco': cliente.endereco,
        'username': cliente.username,
        'password': cliente.password,
      });

      var res = await http.post(
        Uri.parse(ApiEndpoints.userRegisterCliente),
        headers: {'Content-Type': 'application/json'},
        body: clienteJson,
      );

      if (res.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Registro bem-sucedido'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (res.statusCode == 400) {
        errorMessage = res.body;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro de validação'),
              content: Text(errorMessage ?? 'Erro desconhecido'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
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
