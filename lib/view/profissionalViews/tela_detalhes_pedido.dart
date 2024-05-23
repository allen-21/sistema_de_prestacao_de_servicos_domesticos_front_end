import 'package:flutter/material.dart';

class TelaDetalhesPedido extends StatelessWidget {
  const TelaDetalhesPedido({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Text(
              'Número do Pedido: #12345',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Servicos Solicitados :',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text("Anibal Valter"),
            Text("+258 840584001"),
            SizedBox(height: 10.0),
            Text("- Canalizacao"),
            Text("- Reparacao de Torneiras"),
            // OrderItem(name: 'Produto 1', quantity: 2, price: 50.0),
            // OrderItem(name: 'Produto 2', quantity: 1, price: 30.0),
            SizedBox(height: 10.0),
            // Text(
            //   'Total: \$130.00',
            //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 20.0),
            Text(
              'Estado do Pedido:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  // style: ButtonStyle(backgroundColor: Colors.tealAccent),
                  onPressed: null,
                  // onPressed: () {
                  //   return 0; //jjbsak
                  // },
                  child: Text(
                    'Aceitar',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Text(
                    'Recusar',
                    style: TextStyle(fontSize: 24.0, color: Colors.red),
                  ),
                ),
              ],
            ),
            // Text(
            //   'Entregue',
            //   style: TextStyle(fontSize: 16.0),
            // ),
          ],
        ),
      ),
    );
  }
}