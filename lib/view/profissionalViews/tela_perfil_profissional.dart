import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_atualizar_profissional.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/profissional/profissisonal_view_model.dart';

class PerfilProfissional extends StatefulWidget {
  final String token;
  const PerfilProfissional({Key? key, required this.token}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<PerfilProfissional> {
  late ProfissionalViewModel profissionalViewModel;

  @override
  void initState() {
    super.initState();
    profissionalViewModel = ProfissionalViewModel();
    profissionalViewModel.token = widget.token;
    profissionalViewModel.fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => profissionalViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Profissional'),
        ),
        body: Consumer<ProfissionalViewModel>(
          builder: (context, viewModel, child) {
            final userDetails = viewModel.userDetails;
            if (userDetails == null || userDetails.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: [
                  ListTile(
                    title: Text('Nome: ${userDetails["nome"]}'),
                  ),
                  ListTile(
                    title: Text('Telefone: ${userDetails["telefone"]}'),
                  ),
                  ListTile(
                    title: Text('Endereço: ${userDetails["endereco"]}'),
                  ),
                  ListTile(
                    title: Text('Profissões: ${userDetails["profissoes"]}'),
                  ),
                  ListTile(
                    title: Text('Especialidades: ${userDetails["especialidades"]}'),
                  ),
                  ListTile(
                    title: Text('Disponibilidade: ${userDetails["disponibilidade"] ? "Disponível" : "Não disponível"}'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.alterarDisponibilidade(!userDetails["disponibilidade"]);
                    },
                    child: Text(userDetails["disponibilidade"] ? "Tornar Indisponível" : "Tornar Disponível"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateProfissionalScreen(token: widget.token)),
                      );
                    },
                    child: Text('Atualizar Perfil'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
