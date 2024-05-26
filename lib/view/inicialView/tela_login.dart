
import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/inicialView/tela_cadastro.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/login/login_view_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late LoginViewModel viewModel = LoginViewModel();

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
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Usuário',
                prefixIcon: Icon(Icons.person, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (val) {
                viewModel.user.username = val;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Senha',
                prefixIcon: Icon(Icons.lock, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (val) {
                viewModel.user.password = val;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                viewModel.loginUser(context);
              },
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: goToRegister,
              child: const Text(
                'Registrar Conta',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
