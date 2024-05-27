import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/profissional_model.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_services_profissional.dart';


class ProfissaoListsScreen extends StatelessWidget {
  final Profissoes profissao;
  final List<Profissional> profissionais;
 final String token;
  ProfissaoListsScreen({required this.profissao, required this.profissionais, required this.token});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profissionais da Área Escolhida',
          style: TextStyle(color: Colors.white),
        ),
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
                  builder: (context) => ServicosScreen(
                    profissionalId: profissional.id!,
                    token: token,
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profissional.nome ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16, color: Colors.grey),
                              SizedBox(width: 6),
                              Text(
                                '${profissional.telefone ?? ''}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16, color: Colors.grey),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  '${profissional.endereco ?? ''}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.work, size: 16, color: Colors.grey),
                              SizedBox(width: 6),
                              Text(
                                'Especialidades:',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                              SizedBox(width: 6),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 40, // Tamanho maior do CircleAvatar
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
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
