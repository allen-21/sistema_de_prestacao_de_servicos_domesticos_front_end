import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/user_role.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/user_model.dart';

class Administrador extends UserModel {
  Administrador({String? username, String? password})
      : super(username: username, password: password, role: UserRole.ADMIN);
}