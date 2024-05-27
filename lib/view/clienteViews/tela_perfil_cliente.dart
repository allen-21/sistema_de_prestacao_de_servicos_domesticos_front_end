

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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.teal,
                            child: Icon(
                              Icons.person,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ListTile(
                            leading: Icon(Icons.person, color: Colors.teal),
                            title: Text(
                              'Nome: ${viewModel.cliente!.nome}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.phone, color: Colors.teal),
                            title: Text(
                              'Telefone: ${viewModel.cliente!.telefone}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading:
                                Icon(Icons.location_on, color: Colors.teal),
                            title: Text(
                              'Endereço: ${viewModel.cliente!.endereco}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading:
                                Icon(Icons.person_outline, color: Colors.teal),
                            title: Text(
                              'Username: ${viewModel.cliente!.username}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateClienteScreen(token: widget.token),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.teal.shade400,
                            foregroundColor: Colors.white
                          ),
                          icon: Icon(Icons.edit), // Ícone adicionado aqui
                          label: Text(
                            'Atualizar Perfil',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
