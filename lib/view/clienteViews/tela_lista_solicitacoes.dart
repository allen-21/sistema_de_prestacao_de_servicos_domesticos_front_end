import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/estado_pedido.dart';

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
                  trailing: solicitacao.status == EstadoPedido.FEITO ? ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          int pedidoId = solicitacao.id; // Obtém o ID do pedido
                          return AlertDialog(
                            title: Text('Avaliar Serviço'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Avalie o serviço prestado:'),
                                TextField(
                                  decoration: InputDecoration(labelText: 'Nota (0-5)'),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    // Implemente a lógica para validar a nota, se necessário
                                  },
                                ),
                                TextField(
                                  decoration: InputDecoration(labelText: 'Comentário'),
                                  onChanged: (value) {
                                    // Implemente a lógica para capturar o comentário, se necessário
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Adicione a lógica para avaliar o pedido
                                  int nota = 4; // Exemplo de nota
                                  String comentario = 'Ótimo serviço!'; // Exemplo de comentário
                                  viewModel.avaliarSolicitacao(pedidoId, nota, comentario);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Avaliar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Avaliar'),
                  ) : null,
                );
              },
            );
          },
        ),
      ),
    );
  }
}