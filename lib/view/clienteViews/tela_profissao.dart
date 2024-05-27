import 'package:flutter/material.dart';

import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_lista_profissionais.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/profissional/profissao_view_model.dart';


class ProfissaoScreen extends StatelessWidget {
  final String token;
  final ProfissaoViewModel viewModel = ProfissaoViewModel();
  final List<Profissoes> profissoes = Profissoes.values;

  ProfissaoScreen({super.key, required this.token});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Lista de Profissões'),
    ),
    body: ListView.builder(
      itemCount: profissoes.length,
      itemBuilder: (context, index) {
        final profissao = profissoes[index];
        return GestureDetector(
          onTap: () async {
            List<Profissional> profissionais = await viewModel.listarProfissionaisPorProfissao(profissao);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfissaoListsScreen(profissao: profissao, profissionais: profissionais, token: token,),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            width: 100,
            height: 100,
            color: Colors.grey[200],
            child: Center(
              child: Text(
                profissao.descricao,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, // Aumenta o tamanho do texto para torná-lo mais proeminente
                  fontWeight: FontWeight.bold, // Aplica negrito ao texto para maior destaque
                  fontStyle: FontStyle.italic, // Aplica estilo itálico ao texto para adicionar um toque de elegância
                  shadows: [
                    Shadow(
                      color: Colors.grey.withOpacity(0.5), // Define a cor e a opacidade da sombra
                      offset: Offset(2, 2), // Define o deslocamento da sombra
                      blurRadius: 2, // Define o raio de desfoque da sombra
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}


}
