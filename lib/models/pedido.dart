import 'package:sistema_de_prestacao_de_servicos_domesticos/models/clientemodel.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/estado_pedido.dart';

class Pedido {
  final int id;
  final Cliente cliente;
  final String descricao;
  EstadoPedido status;

  Pedido({
    required this.id,
    required this.cliente,
    required this.descricao,
    required this.status,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'] ?? 0,
      cliente: Cliente.fromJson(json['cliente']),
      descricao: json['descricao'] ?? '',
      status: EstadoPedido.values.firstWhere(
        (e) => e.toString() == 'EstadoPedido.${json['status']}',
        orElse: () => EstadoPedido.PENDENTE,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cliente': cliente.toJson(),
      'descricao': descricao,
      'status': status.toString().split('.').last,
    };
  }
}