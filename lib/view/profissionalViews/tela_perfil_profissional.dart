import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_de_prestacao_de_servicos_domesticos/config/api_end_points.dart';
import 'dart:convert';

import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_alterar_perfil.dart';



class PerfilProfissional extends StatefulWidget {
  final String token;
  const PerfilProfissional({Key? key, required this.token}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<PerfilProfissional> {
  Map<String, dynamic> userDetails = {};

  Future<void> fetchUserDetails() async {
    final response = await http.get(
      Uri.parse(ApiEndpoints.userDetalhesProfissional),
      headers: {
        "Authorization": "Bearer ${widget.token}",
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userDetails = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<void> alterarDisponibilidade(bool novaDisponibilidade) async {
    final response = await http.patch(
      Uri.parse(ApiEndpoints.userDisponibilidadeProfissional),
      headers: {
        "Authorization": "Bearer ${widget.token}",
        "Content-Type": "application/json",
      },
      body: json.encode({"novaDisponibilidade": novaDisponibilidade}),
    );

    if (response.statusCode == 200) {
      fetchUserDetails(); //
    } else {
      throw Exception('Failed to update availability');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Profissional'),
      ),
      body: userDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                    alterarDisponibilidade(!userDetails["disponibilidade"]); 
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
            ),
    );
  }
}
