import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_services_profissional.dart';



class ProfissaoListsScreen extends StatelessWidget {
  final Profissoes profissao;
  final List<Profissional> profissionais;

  ProfissaoListsScreen({required this.profissao, required this.profissionais});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profissionais da Área Escolhida'),
      ),
      body: ListView.builder(
        itemCount: profissionais.length,
        itemBuilder: (context, index) {
          final profissional = profissionais[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfissionalDetailScreen(
                    profissionalId: profissional.id!,
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(profissional.nome ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Telefone: ${profissional.telefone ?? ''}'),
                    Text('Localização: ${profissional.endereco ?? ''}'),
                    Text('Especialidades: ${profissional.especialidades ?? ''}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
