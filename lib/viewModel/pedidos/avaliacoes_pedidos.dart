import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/avalicao.dart';

class AvaliacaoViewModel {
  Future<List<Avaliacao>> listarAvaliacoesDoServico(int servicoId) async {
    final response = await http.get(Uri.parse(ApiEndpoints.listaDeAvaliacao(servicoId)));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Avaliacao.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar avaliações');
    }
  }
}