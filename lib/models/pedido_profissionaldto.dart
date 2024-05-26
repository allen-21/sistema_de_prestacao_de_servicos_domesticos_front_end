import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/estado_pedido.dart';

class PedidoProfissionalDTO {
  final int id;
  final int idProfissional;
  final String nomeProfissional;
  final String telefoneProfissional; 
  final String descricao;
  final EstadoPedido status;

  PedidoProfissionalDTO({
    required this.id,
    required this.idProfissional,
    required this.nomeProfissional,
    required this.telefoneProfissional,
    required this.descricao,
    required this.status,
  });

  factory PedidoProfissionalDTO.fromJson(Map<String, dynamic> json) {
    return PedidoProfissionalDTO(
      id: json['id'],
      idProfissional: json['idProfissional'],
      nomeProfissional: json['nomeProfissional'],
      telefoneProfissional: json['telefoneProfissional'], 
      descricao: json['descricao'],
      status: _parseStatus(json['statu']),
    );
  }

  static EstadoPedido _parseStatus(String status) {
    switch (status) {
      case 'PENDENTE':
        return EstadoPedido.PENDENTE;
      case 'FEITO':
        return EstadoPedido.FEITO;
      default:
        throw ArgumentError('Estado de pedido desconhecido: $status');
    }
  }
}
