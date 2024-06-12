import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/user.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/adminviews/admin_view.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/cliente_view.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_inicial_profissional.dart';

class LoginViewModel extends ChangeNotifier {
  late User user = User("", "");

  

  Future<void> loginUser(BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse(ApiEndpoints.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': user.username, 'password': user.password}),
      );
      print(res.body);
      if (res.statusCode == 200) {
        var token = json.decode(res.body)['token'];

        var userInfoRes = await http.get(
          Uri.parse(ApiEndpoints.userInfoRoleUrl),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (userInfoRes.statusCode == 200) {
          var role = json.decode(userInfoRes.body)['role'];

          switch (role) {
            case 'ROLE_ADMIN':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminWelcomeScreen(token: token),
                ),
              );
              break;
            case 'ROLE_CLIENTE':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientWelcomeScreen(token: token),
                ),
              );
              break;
            case 'ROLE_PROF':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfissionalMenu(token: token),
                ),
              );
              break;
            default:
              break;
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro'),
                content: const Text('Erro ao obter informações do usuário.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro de Autenticação'),
              content: const Text('Usuário ou senha incorretos.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: Text('Ocorreu um erro: $error'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
