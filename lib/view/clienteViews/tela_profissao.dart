import 'package:flutter/material.dart';

import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_lista_profissionais.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/profissional/profissao_view_model.dart';


class ProfissaoScreen extends StatelessWidget {
  final ProfissaoViewModel viewModel = ProfissaoViewModel();
  final List<Profissoes> profissoes = Profissoes.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Profissões'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: profissoes.length,
        itemBuilder: (context, index) {
          final profissao = profissoes[index];
          return GestureDetector(
            onTap: () async {
              List<Profissional> profissionais = await viewModel.listarProfissionaisPorProfissao(profissao);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfissaoListsScreen(profissao: profissao, profissionais: profissionais),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  profissao.descricao,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
