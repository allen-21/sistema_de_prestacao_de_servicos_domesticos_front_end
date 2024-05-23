import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/user_role.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/servico_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/user_model.dart';

class Profissional extends UserModel {
  Profissoes profissoes;
  String especialidades;
  bool disponibilidade;
  List<Servico> servicos = [];

  Profissional({
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
}