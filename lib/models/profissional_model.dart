import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/user_role.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/user_model.dart';

class Profissional extends UserModel {
  int? id; // Adicione o campo id aqui
  Profissoes profissoes;
  String especialidades;
  bool disponibilidade;

  Profissional({
    this.id, // Inclua o campo id no construtor
    String? nome,
    String? telefone,
    String? endereco,
    String? username,
    String? password,
    required this.profissoes,
    required this.especialidades,
    this.disponibilidade = true,
  }) : super(
          nome: nome,
          telefone: telefone,
          endereco: endereco,
          username: username,
          password: password,
          role: UserRole.PROFISSIONAL,
        );

  factory Profissional.fromJson(Map<String, dynamic> json) {
    return Profissional(
      id: json['id'], // Inclua o campo id na desserialização do JSON
      nome: json['nome'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      username: json['username'],
      password: json['password'],
      profissoes: ProfissoesExtension.fromString(json['profissoes']),
      especialidades: json['especialidades'],
      disponibilidade: json['disponibilidade'],
    );
  }
}
