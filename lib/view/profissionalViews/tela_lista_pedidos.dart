import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/estado_pedido.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/pedidos/pedido_view_model.dart';


class PedidosProfissionalScreen extends StatelessWidget {
  final String token;

  const PedidosProfissionalScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PedidoViewModel(token: token)..listarPedidos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pedidos do Profissional'),
        ),
        body: Consumer<PedidoViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.pedidos.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: viewModel.pedidos.length,
              itemBuilder: (context, index) {
                final pedido = viewModel.pedidos[index];

                return ListTile(
                  title: Text(pedido.descricao),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cliente: ${pedido.cliente.nome}'),
                      Text('Telefone: ${pedido.cliente.telefone}'),
                      Text('Status: ${pedido.status}'),
                    ],
                  ),
                  trailing: DropdownButton<EstadoPedido>(
                    value: pedido.status,
                    onChanged: (EstadoPedido? novoEstado) {
                      if (novoEstado != null) {
                        viewModel.alterarEstadoPedido(pedido.id, novoEstado);
                      }
                    },
                    items: EstadoPedido.values.map((EstadoPedido estado) {
                      return DropdownMenuItem<EstadoPedido>(
                        value: estado,
                        child: Text(estado.toString().split('.').last),
                      );
                    }).toList(),
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
