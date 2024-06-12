import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/servico.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_avalicoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/viewModel/servicos/servicos_view_model.dart';
class ServicosScreen extends StatefulWidget {
  final int profissionalId;
  final String token;

  ServicosScreen({required this.profissionalId, required this.token});

  @override
  _ServicosScreenState createState() => _ServicosScreenState();
}

class _ServicosScreenState extends State<ServicosScreen> {
  late TextEditingController _descricaoController;
  late TextEditingController _dataHoraController;

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController();
    _dataHoraController = TextEditingController(
        text: DateFormat('yyyy-MM-ddTHH:mm').format(DateTime.now()));
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _dataHoraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços do Profissional'),
      ),
      body: FutureBuilder<List<Servico>>(
        future: Provider.of<ServicosViewModel>(context, listen: false)
            .listarServicosDoProfissional(widget.profissionalId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar serviços'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum serviço encontrado'));
          } else {
            final servicos = snapshot.data!;
            return ListView.builder(
              itemCount: servicos.length,
              itemBuilder: (context, index) {
                final servico = servicos[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          servico.descricaoDoServico,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _mostrarDialogoEnvioPedido(
                                    context, servico.id, widget.token);
                              },
                              icon: Icon(Icons.playlist_add),
                              label: Text('Solicitar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AvaliacaoScreen(
                                      servicoId: servico.id,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.rate_review),
                              label: Text('Ver Avaliações'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _mostrarDialogoEnvioPedido(
      BuildContext context, int servicoId, String token) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enviar Pedido'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: _dataHoraController,
                decoration: InputDecoration(labelText: 'Data e Hora'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Envie o pedido
                    final responseMessage =
                        await Provider.of<ServicosViewModel>(context,
                                listen: false)
                            .enviarPedido(
                      token: token,
                      servicoId: servicoId,
                      descricao: _descricaoController.text.trim(),
                      dataHora: _dataHoraController.text.trim(),
                    );

                    // Exiba uma mensagem de sucesso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(responseMessage),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Feche o diálogo
                    Navigator.of(context).pop();
                  } catch (e) {
                    // Exiba uma mensagem de erro em caso de falha
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        );
      },
    );
  }
}