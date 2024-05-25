import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/models/enum/profissoes.dart';

class UpdateProfissionalScreen extends StatefulWidget {
  final String token;
  const UpdateProfissionalScreen({super.key, required this.token});

  @override
  _UpdateProfissionalScreenState createState() =>
      _UpdateProfissionalScreenState();
}
class _UpdateProfissionalScreenState extends State<UpdateProfissionalScreen> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController especialidadesController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool disponibilidade = true;
  Profissoes? profissaoSelecionada;

  @override
  void initState() {
    super.initState();
    _carregarInformacoesProfissional();
  }

Future<void> _carregarInformacoesProfissional() async {
  try {
    Uri url = Uri.parse(ApiEndpoints.userDetalhesProfissional);
    Map<String, String> headers = {
      "Authorization": "Bearer ${widget.token}",
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
     
      Map<String, dynamic> data = json.decode(response.body);
    
      setState(() {
        nomeController.text = data['nome'];
        telefoneController.text = data['telefone'];
        enderecoController.text = data['endereco'];
        especialidadesController.text = data['especialidades'];
        disponibilidade = data['disponibilidade'];
      
        profissaoSelecionada = ProfissoesExtension.fromString(data['profissoes']);
      });
    } else {
      throw Exception('Erro ao carregar informações do profissional');
    }
  } catch (e) {
    print(e.toString());
  }
}



  Future<void> _atualizarProfissional() async {
    Uri url = Uri.parse(ApiEndpoints.userUpdateProfissional);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${widget.token}",
    };
    String json = jsonEncode({
      "nome": nomeController.text,
      "telefone": telefoneController.text,
      "endereco": enderecoController.text,
      "profissoes": profissaoSelecionada?.toString().split('.').last ?? '', 
      "especialidades": especialidadesController.text,
      "password": passwordController.text,
      "disponibilidade": disponibilidade.toString(),
    });

    try {
      final response = await http.put(url, headers: headers, body: json);
      if (response.statusCode == 200) {
   
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profissional atualizado com sucesso'),
          duration: Duration(seconds: 2),
          ));
           Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });


      } else {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao atualizar o profissional')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Profissional'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                controller: telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
              ),
              DropdownButtonFormField<Profissoes>(
                value: profissaoSelecionada,
                onChanged: (value) {
                  setState(() {
                    profissaoSelecionada = value;
                  });
                },
                items: Profissoes.values.map((Profissoes profissao) {
                  return DropdownMenuItem<Profissoes>(
                    value: profissao,
                    child: Text(profissao.descricao),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Profissão',
                  prefixIcon: Icon(Icons.work),
                ),
              ),
              TextFormField(
                controller: especialidadesController,
                decoration: InputDecoration(labelText: 'Especialidades'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Nova Senha'),
              ),
              CheckboxListTile(
                title: Text('Disponibilidade'),
                value: disponibilidade,
                onChanged: (value) {
                  setState(() {
                    disponibilidade = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _atualizarProfissional();
                },
                child: Text('Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
