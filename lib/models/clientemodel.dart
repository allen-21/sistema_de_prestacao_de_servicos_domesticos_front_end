import 'package:sistema_de_prestacao_de_servicos_domesticos/models/user_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/user_role.dart';

class Cliente extends UserModel {
  Cliente(
      {String? nome,
      String? telefone,
      String? endereco,
      String? username,
      String? password})
      : super(
            nome: nome,
            telefone: telefone,
            endereco: endereco,
            username: username,
            password: password,
            role: UserRole.CLIENTE);

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      nome: json['nome'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      username: json['username'],
      password: json['password'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['role'] = 'CLIENTE'; // Override role to ensure it is always CLIENTE
    return data;
  }
}
