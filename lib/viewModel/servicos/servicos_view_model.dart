import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/servico.dart';

class ServicosViewModel extends ChangeNotifier {
  Future<List<Servico>> listarServicosDoProfissional(int idProfissional) async {
    final response = await http.get(
      Uri.parse(ApiEndpoints.listarServiceByIdProfissional(idProfissional)),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Servico> servicos = body.map((dynamic item) => Servico.fromJson(item)).toList();
      return servicos;
    } else {
      throw Exception('Falha ao carregar serviços do profissional');
    }
  }

  //Pedido
  Future<String> enviarPedido({
    required String token,
    required int servicoId,
    required String descricao,
  }) async {
    final Map<String, dynamic> requestBody = {
      'servicoId': servicoId,
      'descricao': descricao,
      'status': 'PENDENTE', 
    };

    final response = await http.post(
      Uri.parse(ApiEndpoints.pedidoEnviar),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      return 'Pedido realizado com sucesso!';
    } else if (response.statusCode == 401) {
      throw Exception('Erro: Operação não autorizada.');
    } else {
      throw Exception('Erro ao realizar pedido.');
    }
  }
}
