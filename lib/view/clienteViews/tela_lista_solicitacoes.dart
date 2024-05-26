import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/pedidos/pedido_view_model.dart';
class ClienteListSolicitaco extends StatelessWidget {
  final String token;
  const ClienteListSolicitaco({Key? key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PedidoViewModel(token: token)..listarSolicitacoes(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pedidos do Cliente'),
        ),
        body: Consumer<PedidoViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.solicitacoes.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: viewModel.solicitacoes.length,
              itemBuilder: (context, index) {
                final solicitacao = viewModel.solicitacoes[index];

                return ListTile(
                  title: Text(solicitacao.descricao),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profissional: ${solicitacao.nomeProfissional}'),
                      Text('Telefone: ${solicitacao.telefoneProfissional}'), 
                      Text('Status: ${solicitacao.status}'),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
