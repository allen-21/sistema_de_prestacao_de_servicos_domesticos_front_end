

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_atualizar_cliente.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/cliente/cliente_view.dart';

class PerfilCliente extends StatefulWidget {
  final String token;
  const PerfilCliente({super.key, required this.token});

  @override
  State<PerfilCliente> createState() => _PerfilClienteState();
}

class _PerfilClienteState extends State<PerfilCliente> {
  late ClienteViewModel clienteViewModel;

  @override
  void initState() {
    super.initState();
    clienteViewModel = ClienteViewModel();
    clienteViewModel.token = widget.token;
    clienteViewModel.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => clienteViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Cliente'),
        ),
        body: Consumer<ClienteViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.cliente == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: [
                  ListTile(
                    title: Text('Nome: ${viewModel.cliente!.nome}'),
                  ),
                  ListTile(
                    title: Text('Telefone: ${viewModel.cliente!.telefone}'),
                  ),
                  ListTile(
                    title: Text('Endereço: ${viewModel.cliente!.endereco}'),
                  ),
                  ListTile(
                    title: Text('Username: ${viewModel.cliente!.username}'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateClienteScreen(token: widget.token),
                        ),
                      );
                    },
                    child: Text('Atualizar Perfil'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
