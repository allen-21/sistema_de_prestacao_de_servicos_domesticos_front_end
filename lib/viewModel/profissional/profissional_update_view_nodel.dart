// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';

class ProfissionalUpdateViewModel extends ChangeNotifier {
    BuildContext context;
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController especialidadesController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool disponibilidade = true;
  Profissoes? profissaoSelecionada;
  String? token;
  ProfissionalUpdateViewModel(
    this.context,
 
  );

  Future<void> carregarInformacoesProfissional() async {
    try {
      Uri url = Uri.parse(ApiEndpoints.userDetalhesProfissional);
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        nomeController.text = data['nome'] ?? '';
        telefoneController.text = data['telefone'] ?? '';
        enderecoController.text = data['endereco'] ?? '';
        especialidadesController.text = data['especialidades'] ?? '';
        disponibilidade = data['disponibilidade'] ?? true;
        profissaoSelecionada =
            ProfissoesExtension.fromString(data['profissoes']);
        notifyListeners();
      } else {
        throw Exception('Erro ao carregar informações do profissional');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> atualizarProfissional() async {
    Uri url = Uri.parse(ApiEndpoints.userUpdateProfissional);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token",
    };
    String json = jsonEncode({
      "nome": nomeController.text,
      "telefone": telefoneController.text,
      "endereco": enderecoController.text,
      "profissoes": profissaoSelecionada?.toString().split('.').last ?? '',
      "especialidades": especialidadesController.text,
      "password": passwordController.text,
      "disponibilidade": disponibilidade.toString(),
    });

    try {
      final response = await http.put(url, headers: headers, body: json);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profissional atualizado com sucesso'),
          duration: Duration(seconds: 2),
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao atualizar o profissional')));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
