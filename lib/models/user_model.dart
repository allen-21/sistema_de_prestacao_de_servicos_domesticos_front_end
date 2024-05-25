import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/user_role.dart';

class UserModel {
  String? nome;
  String? telefone;
  String? endereco;
  String? username;
  String? password;
  UserRole role;

  UserModel(
      {this.nome,
      this.telefone,
      this.endereco,
      this.username,
      this.password,
      required this.role});
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nome: json['nome'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      username: json['username'],
      password: json['password'],
      role: UserRole.values.firstWhere((e) => e.toString() == 'UserRole.' + json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'telefone': telefone,
      'endereco': endereco,
      'username': username,
      'password': password,
      'role': role.toString().split('.').last,
    };
  }
}