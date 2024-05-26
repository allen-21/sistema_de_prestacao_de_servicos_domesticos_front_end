
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';

class Servico {
  final int id;
  final Profissional? profissional;
  final String descricaoDoServico;

  Servico({
    required this.id,
    required this.profissional,
    required this.descricaoDoServico,
  });

  factory Servico.fromJson(Map<String, dynamic> json) {
    return Servico(
      id: json['id'],
      profissional: json['profissional'] != null
          ? Profissional.fromJson(json['profissional'])
          : null,
      descricaoDoServico: json['descricaoDoServico'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profissional': profissional?.toJson(),
      'descricaoDoServico': descricaoDoServico,
    };
  }
}
