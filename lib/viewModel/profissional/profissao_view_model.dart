import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';




class ProfissaoViewModel extends ChangeNotifier {
  

  Future<List<Profissional>> listarProfissionaisPorProfissao(Profissoes profissao) async {
    final response = await http.get(
      Uri.parse(ApiEndpoints.listarProfissionaisPorProfissao(profissao.toString().split('.').last)), // Use a classe ApiEndpoints para obter a URL
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Profissional> profissionais = body.map((dynamic item) => Profissional.fromJson(item)).toList();
      return profissionais;
    } else {
      throw Exception('Falha ao carregar profissionais por profissão');
    }
  }


 Future<List<Profissional>> listarProfissionaisPorTermo(String termo) async {
    final url = ApiEndpoints.listarProfissionaisPorTermo(termo);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Profissional.fromJson(json)).toList();
    } else {

      throw Exception('Falha ao carregar profissionais');
    }
  }
}



