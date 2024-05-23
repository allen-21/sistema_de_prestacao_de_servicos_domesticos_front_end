import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/user_role.dart';

class UserModel {
  String? nome;
  String? telefone;
  String? endereco;
  String? username;
  String? password;
  UserRole? role;

  UserModel( 
      {this.nome,
      this.telefone,
      this.endereco,
      this.username,
      this.password,
      this.role});

 
}