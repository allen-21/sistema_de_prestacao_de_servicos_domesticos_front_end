import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/estado_pedido.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/pedidos/pedido_view_model.dart';

class PedidosProfissionalScreen extends StatelessWidget {
  final String token;

  const PedidosProfissionalScreen({Key? key, required this.token})
      : super(key: key);

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

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      pedido.descricao.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Cliente: ${pedido.cliente.nome}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Telefone: ${pedido.cliente.telefone}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Status: ${pedido.status.index == 0 ? "Pendente" : "Feito"}',
                          style: TextStyle(fontSize: 16),
                        ),
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
                        Color? cor;
                        if (estado == EstadoPedido.PENDENTE) {
                          cor = Colors.red;
                        } else {
                          cor = Colors.green;
                        }
                        return DropdownMenuItem<EstadoPedido>(
                          value: estado,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: cor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              estado.toString().split('.').last,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                      underline: Container(),
                    ),
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
