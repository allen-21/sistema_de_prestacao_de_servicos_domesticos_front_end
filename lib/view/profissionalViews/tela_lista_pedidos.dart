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

                return Center(
                  // Adiciona um padding de 16.0 à esquerda
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: pedido.status.index == 0
                        ? Colors.red[800]
                        : Colors.blue[800],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.0), // Espaçamento à esquerda do texto
                          child: ListTile(
                            title: Text(
                              pedido.descricao.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.0),
                                Text(
                                  'Cliente: ${pedido.cliente.nome}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Telefone: ${pedido.cliente.telefone}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Status: ${pedido.status.index == 0 ? "Pendente" : "Feito"}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                            trailing: DropdownButton<EstadoPedido>(
                              value: pedido.status,
                              style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontSize: 20.0,
                                  color: Colors.black),
                              onChanged: (EstadoPedido? novoEstado) {
                                if (novoEstado != null) {
                                  viewModel.alterarEstadoPedido(
                                      pedido.id, novoEstado);
                                }
                              },
                              items: EstadoPedido.values
                                  .map((EstadoPedido estado) {
                                return DropdownMenuItem<EstadoPedido>(
                                  value: estado,
                                  child:
                                      Text(estado.toString().split('.').last),
                                );
                              }).toList(),
                              // style: TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 16,
                              //     backgroundColor: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
