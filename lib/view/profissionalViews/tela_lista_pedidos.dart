import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_detalhes_pedido.dart';

class ListaPedidos extends StatelessWidget {
  const ListaPedidos({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
      ),
      body: ListView.builder(
        itemCount: 1, // Substitua pelo número real de pedidos
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Pedido ${index + 1}',
                style: const TextStyle(fontSize: 24.0, color: Colors.teal)),
            subtitle: Text('Detalhes do pedido ${index + 1}',
                style: const TextStyle(fontSize: 18.0)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navegue para a tela de registro
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TelaDetalhesPedido()),
              );
            },
          );
        },
      ),

      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => TelaDetalhesPedido(index + 1),
      //     ),
      //   );
      // },
    );
  }
  // ),
  // );
}