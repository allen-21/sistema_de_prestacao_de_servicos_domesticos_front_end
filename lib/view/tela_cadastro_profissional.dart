
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'dart:convert';

import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/tela_login.dart';


class TelaCadastroProfissional extends StatefulWidget {
  const TelaCadastroProfissional({super.key});


  @override
  _TelaCadastroProfissionalState createState() => _TelaCadastroProfissionalState();
}

class _TelaCadastroProfissionalState extends State<TelaCadastroProfissional> {
  final _formKey = GlobalKey<FormState>();
  Profissional profissional = Profissional(
    nome: '',
    telefone: '',
    endereco: '',
    username: '',
    password: '',
    profissoes: Profissoes.LIMPEZA,
    especialidades: '',
  );
  String url = "http://192.168.39.91:8080/profissional/criar";
  String? errorMessage;

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      var profissionalJson = json.encode({
        'nome': profissional.nome,
        'telefone': profissional.telefone,
        'endereco': profissional.endereco,
        'username': profissional.username,
        'password': profissional.password,
        'profissoes': profissional.profissoes.toString().split('.').last,
        'especialidades': profissional.especialidades,
        'disponibilidade': profissional.disponibilidade,
      });

      var res = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: profissionalJson,
      );

      if (res.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sucesso'),
              content: Text('Registro bem-sucedido'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (res.statusCode == 400) {
        var errorMessage = res.body;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro de validação'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Erro ao registrar: ${res.body}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Profissional'),
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
                    setState(() {
                      profissional.nome = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    prefixIcon: Icon(Icons.home),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      profissional.endereco = val;
                    });
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
                    setState(() {
                      profissional.telefone = val;
                    });
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
                    setState(() {
                      profissional.username = val;
                    });
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
                    setState(() {
                      profissional.password = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<Profissoes>(
                  value: profissional.profissoes,
                  onChanged: (value) {
                    setState(() {
                      profissional.profissoes = value!;
                    });
                  },
                  items: Profissoes.values.map((Profissoes profissao) {
                    return DropdownMenuItem<Profissoes>(
                      value: profissao,
                      child: Text(profissao.toString().split('.').last),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Profissão',
                    prefixIcon: Icon(Icons.work),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Especialidades',
                    prefixIcon: Icon(Icons.work),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      profissional.especialidades = val;
                    });
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
