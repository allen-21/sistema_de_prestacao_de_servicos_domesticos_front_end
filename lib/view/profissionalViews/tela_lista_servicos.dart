import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAndListServicesScreen extends StatefulWidget {
  final String token;

  const AddAndListServicesScreen({Key? key, required this.token}) : super(key: key);

  @override
  _AddAndListServicesScreenState createState() => _AddAndListServicesScreenState();
}

class _AddAndListServicesScreenState extends State<AddAndListServicesScreen> {
  TextEditingController _serviceDescriptionController = TextEditingController();
  List<String> _services = [];

  String addServiceUrl = "http://192.168.39.91:8080/servicos/adicionar";
  String listServiceUrl = "http://192.168.39.91:8080/servicos/meus";


  

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      var response = await http.get(
        Uri.parse(listServiceUrl),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<String> descriptions = data.map((item) => item['descricaoDoServico'] as String).toList();
        setState(() {
          _services = descriptions;
        });
      } else {
        print('Erro ao listar os serviços: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro na requisição HTTP: $error');
    }
  }

  void _addService() async {
    String description = _serviceDescriptionController.text;

    try {
      var response = await http.post(
        Uri.parse(addServiceUrl),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
        body: json.encode({'descricaoDoServico': description}),
      );

      if (response.statusCode == 201) {
        setState(() {
          _services.add(description);
        });
        _serviceDescriptionController.clear();
        print('Serviço adicionado com sucesso');
      } else {
        print('Erro ao adicionar o serviço: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro na requisição HTTP: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar e Listar Serviços'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _serviceDescriptionController,
                maxLines: null, 
                keyboardType: TextInputType.multiline, 
                decoration: const InputDecoration(
                  labelText: 'Descrição do Serviço',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _addService();
              },
              child: const Text('Adicionar Serviço'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              flex: 2,
              child: _services.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _services.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(_services[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
