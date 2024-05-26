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
          centerTitle: true,
        ),
        body: Consumer<ProfissionalViewModel>(
          builder: (context, viewModel, child) {
            final userDetails = viewModel.userDetails;
            if (userDetails == null || userDetails.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.teal,
                      backgroundImage: userDetails["profileImageUrl"] != null &&
                              userDetails["profileImageUrl"].isNotEmpty
                          ? NetworkImage(userDetails["profileImageUrl"])
                          : null,
                      child: userDetails["profileImageUrl"] == null ||
                              userDetails["profileImageUrl"].isEmpty
                          ? Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person, color: Colors.teal),
                            title: Text(
                              'Nome: ${userDetails["nome"]}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.phone, color: Colors.teal),
                            title: Text(
                              'Telefone: ${userDetails["telefone"]}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading:
                                Icon(Icons.location_on, color: Colors.teal),
                            title: Text(
                              'Endereço: ${userDetails["endereco"]}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.work, color: Colors.teal),
                            title: Text(
                              'Profissões: ${userDetails["profissoes"]}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.star, color: Colors.teal),
                            title: Text(
                              'Especialidades: ${userDetails["especialidades"]}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              userDetails["disponibilidade"]
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: userDetails["disponibilidade"]
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            title: Text(
                              'Disponibilidade: ${userDetails["disponibilidade"] ? "Disponível" : "Não disponível"}',
                              style: TextStyle(
                                fontSize: 18,
                                color: userDetails["disponibilidade"]
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        viewModel.alterarDisponibilidade(
                            !userDetails["disponibilidade"]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: userDetails["disponibilidade"]
                            ? Colors.redAccent
                            : Colors.green,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(
                        userDetails["disponibilidade"]
                            ? Icons.cancel
                            : Icons.check_circle,
                        color: Colors.white,
                      ),
                      label: Text(
                        userDetails["disponibilidade"]
                            ? "Tornar Indisponível"
                            : "Tornar Disponível",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateProfissionalScreen(
                                  token: widget.token)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.edit, color: Colors.white),
                      label: Text(
                        'Atualizar Perfil',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
