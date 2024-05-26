import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/profissional/profissional_cadastro_view_model.dart';

class TelaCadastroProfissional extends StatefulWidget {
  const TelaCadastroProfissional({super.key});

  @override
  _TelaCadastroProfissionalState createState() => _TelaCadastroProfissionalState();
}

class _TelaCadastroProfissionalState extends State<TelaCadastroProfissional> {
  final CadastroViewModel viewModel = CadastroViewModel();

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
            key: viewModel.formKey,
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
                      viewModel.profissional.nome = val;
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
                      viewModel.profissional.endereco = val;
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
                      viewModel.profissional.telefone = val;
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
                      viewModel.profissional.username = val;
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
                      viewModel.profissional.password = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<Profissoes>(
                  value: viewModel.profissional.profissoes,
                  onChanged: (value) {
                    setState(() {
                      viewModel.profissional.profissoes = value!;
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
                      viewModel.profissional.especialidades = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => viewModel.save(context),
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
                    // handle terms of service
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
                    // handle privacy policy
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
