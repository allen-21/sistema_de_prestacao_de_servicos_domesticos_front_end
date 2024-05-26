

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/cliente/cliente_view.dart';

class UpdateClienteScreen extends StatefulWidget {
  final String token;
  const UpdateClienteScreen({super.key, required this.token});

  @override
  State<UpdateClienteScreen> createState() => _UpdateClienteScreenState();
}

class _UpdateClienteScreenState extends State<UpdateClienteScreen> {
  late ClienteViewModel clienteViewModel;

  @override
  void initState() {
    super.initState();
    clienteViewModel = ClienteViewModel();
    clienteViewModel.token = widget.token;
    clienteViewModel.carregarInformacoesCliente();
  }

 @override
Widget build(BuildContext context) {
  return ChangeNotifierProvider(
    create: (context) => clienteViewModel,
    child: Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Cliente'),
      ),
      body: Consumer<ClienteViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Adicionar lógica para editar a foto do perfil
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: viewModel.nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Digite seu nome',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: viewModel.telefoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Digite seu telefone',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: viewModel.enderecoController,
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                    hintText: 'Digite seu endereço',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: viewModel.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Nova Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Digite sua nova senha',
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.atualizarCliente().then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Cliente atualizado com sucesso'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.pop(context);
                        });
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao atualizar o Cliente'),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.teal,
                      elevation: 3,
                    ),
                    child: Text(
                      'Atualizar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}




}
