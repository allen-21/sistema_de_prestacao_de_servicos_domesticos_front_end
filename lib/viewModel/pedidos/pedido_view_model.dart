import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/estado_pedido.dart';
import 'dart:convert';

import 'package:sistema_de_prestacao_de_servicos_domesticos/models/pedido.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/pedido_profissionaldto.dart';



class PedidoViewModel extends ChangeNotifier {
  final String token;
  List<Pedido> pedidos = [];
  List<PedidoProfissionalDTO> solicitacoes = []; 

  PedidoViewModel({required this.token});

  Future<void> listarPedidos() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.pedidoListarProfissional), 
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        pedidos = data.map((json) => Pedido.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Falha ao carregar pedidos');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> listarSolicitacoes() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.pedidoListarCliente), 
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        solicitacoes = data.map((json) => PedidoProfissionalDTO.fromJson(json)).toList(); 
        notifyListeners();
      } else {
        throw Exception('Falha ao carregar pedidos');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> alterarEstadoPedido(int pedidoId, EstadoPedido novoEstado) async {
    try {
      final response = await http.put(
        Uri.parse(ApiEndpoints.pedidoAtualizarEstado(pedidoId)),  
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'novoStatus': novoEstado.toString().split('.').last}),
      );

      if (response.statusCode == 200) {
        listarPedidos(); 
      } else {
        throw Exception('Falha ao alterar o estado do pedido');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
