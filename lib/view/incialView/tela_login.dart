import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'dart:convert';

import 'package:sistema_de_prestacao_de_servicos_domesticos/models/user.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/adminviews/admin_view.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/cliente_view.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_inicial_profissional.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/incialView/tela_cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");

  Future<void> save() async {
    try {
      var res = await http.post(
        Uri.parse(ApiEndpoints.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body:
            json.encode({'username': user.username, 'password': user.password}),
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

  void goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastro()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 71, 90), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Faça Login',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)), 
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Usuário',
                prefixIcon: Icon(Icons.person,
                    color: Colors.white), 
              ),
              style: TextStyle(
                  color: Colors.white), 
              onChanged: (val) {
                user.username = val;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Senha',
                prefixIcon: Icon(Icons.lock,
                    color: Colors.white), 
              ),
              style: TextStyle(
                  color: Colors.white), 
              onChanged: (val) {
                user.password = val;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                save();
              },
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: goToRegister,
              child: const Text(
                'Registrar Conta',
                style: TextStyle(
                    color: Colors.white), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
