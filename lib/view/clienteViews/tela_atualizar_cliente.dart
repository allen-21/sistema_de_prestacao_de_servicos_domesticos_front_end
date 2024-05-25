

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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: viewModel.nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextFormField(
                      controller: viewModel.telefoneController,
                      decoration: InputDecoration(labelText: 'Telefone'),
                    ),
                    TextFormField(
                      controller: viewModel.enderecoController,
                      decoration: InputDecoration(labelText: 'Endereço'),
                    ),
                    TextFormField(
                      controller: viewModel.passwordController,
                      decoration: InputDecoration(labelText: 'Nova Senha'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
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
                      child: Text('Atualizar'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
