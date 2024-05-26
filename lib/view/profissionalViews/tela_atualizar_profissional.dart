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
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Adicione aqui a lógica para selecionar uma imagem
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey[600],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal,
                          ),
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: enderecoController,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
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
                decoration: InputDecoration(
                  labelText: 'Profissão',
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: especialidadesController,
                decoration: InputDecoration(
                  labelText: 'Especialidades',
                  prefixIcon: Icon(Icons.star),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Nova Senha',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('Disponibilidade'),
                value: disponibilidade,
                onChanged: (value) {
                  setState(() {
                    disponibilidade = value!;
                  });
                },
                activeColor: Colors.teal,
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _atualizarProfissional();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.update, color: Colors.white),
                  label: Text(
                    'Atualizar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
