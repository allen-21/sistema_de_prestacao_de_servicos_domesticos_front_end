import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/avalicao.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/pedidos/avaliacoes_pedidos.dart';

class AvaliacaoScreen extends StatelessWidget {
  final int servicoId;
  final AvaliacaoViewModel viewModel = AvaliacaoViewModel();

  AvaliacaoScreen({Key? key, required this.servicoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliações do Serviço'),
      ),
      body: FutureBuilder<List<Avaliacao>>(
        future: viewModel.listarAvaliacoesDoServico(servicoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar avaliações'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma avaliação encontrada'));
          } else {
            List<Avaliacao> avaliacoes = snapshot.data!;
            return ListView.builder(
              itemCount: avaliacoes.length,
              itemBuilder: (context, index) {
                final avaliacao = avaliacoes[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nota: ${avaliacao.nota}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          avaliacao.comentario,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
