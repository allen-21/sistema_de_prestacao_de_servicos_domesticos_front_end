

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/clientemodel.dart';

class ClienteViewModel extends ChangeNotifier {
  Cliente? cliente;
  String? token;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> carregarInformacoesCliente() async {
    try {
      Uri url = Uri.parse(ApiEndpoints.userDetalheCliente);
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        cliente = Cliente.fromJson(json.decode(response.body));
        nomeController.text = cliente!.nome ?? '';
        telefoneController.text = cliente!.telefone ?? '';
        enderecoController.text = cliente!.endereco ?? '';
        usernameController.text = cliente!.username ?? '';
        notifyListeners();
      } else {
        throw Exception('Erro ao carregar informações do Cliente');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> atualizarCliente() async {
    Uri url = Uri.parse(ApiEndpoints.userUpdateCliente);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token",
    };
    String json = jsonEncode({
      "nome": nomeController.text,
      "telefone": telefoneController.text,
      "endereco": enderecoController.text,
      "username": usernameController.text,
      "password": passwordController.text,
    });

    try {
      final response = await http.put(url, headers: headers, body: json);
      if (response.statusCode == 200) {
        cliente = Cliente.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {
        throw Exception('Erro ao atualizar o Cliente');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.userDetalheCliente),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        cliente = Cliente.fromJson(json.decode(response.body));
        notifyListeners();
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
