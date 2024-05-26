import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_de_prestacao_de_servicos_domesticos/models/servico.dart';
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

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController();
  }

  @override
  void dispose() {
    _descricaoController.dispose();
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
                  child: ListTile(
                    title: Text(servico.descricaoDoServico),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _mostrarDialogoEnvioPedido(
                            context, servico.id, widget.token);
                      },
                      child: Text('Solicitar'),
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
