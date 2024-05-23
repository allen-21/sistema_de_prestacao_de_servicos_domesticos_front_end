import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/clientemodel.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/tela_login.dart';



class TelaCadastroCliente extends StatefulWidget {
  const TelaCadastroCliente({super.key});

 

  @override
  _TelaCadastroClienteState createState() => _TelaCadastroClienteState();
}

class _TelaCadastroClienteState extends State<TelaCadastroCliente> {
  final _formKey = GlobalKey<FormState>();
  Cliente cliente = Cliente(nome: '', telefone: '', endereco: '', username: '', password: '');
  String url = "http://192.168.39.91:8080/cliente/criar";
  String? errorMessage;


Future<void> save() async {
  if (_formKey.currentState!.validate()) {
    var clienteJson = json.encode({
      'nome': cliente.nome,
      'telefone': cliente.telefone,
      'endereco': cliente.endereco,
      'username': cliente.username,
      'password': cliente.password,
    });

    var res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: clienteJson,
    );

    if (res.statusCode == 201) {
      // Registro bem-sucedido, redireciona para a tela de login
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sucesso'),
            content: const Text('Registro bem-sucedido'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (res.statusCode == 400) {
      // Erro de validação
      var errorMessage = res.body;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro de validação'),
            content: Text(errorMessage),
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
    } else {
      // Outro tipo de erro
      print('Erro ao registrar: ${res.body}');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    cliente.nome = val;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Endereco',
                    prefixIcon: Icon(Icons.home),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    cliente.endereco = val;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    cliente.telefone = val;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    cliente.username = val;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    cliente.password = val;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: save,
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Ao clicar em "Cadastrar", você concorda com nossos Termos de Serviço e Política de Privacidade.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Adicione a lógica para abrir os Termos de Serviço
                  },
                  child: const Text(
                    'Termos de Serviço',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Adicione a lógica para abrir a Política de Privacidade
                  },
                  child: const Text(
                    'Política de Privacidade',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
