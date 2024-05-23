import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_perfil_profissional.dart';

class AlterarPerfil extends StatefulWidget {
  const AlterarPerfil({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

String? _selectedLocation;

final List<String> locations = [
  'Maputo Cidade',
  'Maputo Província',
];

final Map<String, List<String>> districts = {
  'Maputo Cidade': ['KaMpfumo', 'KaMaxaquene', 'KaMavota', 'KaMubukwana'],
  'Maputo Província': ['Manhiça', 'Matola', 'Boane', 'Namaacha'],
};

String? _selectedDistrict;

class _ProfileScreenState extends State<AlterarPerfil> {
  bool _availability = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar dados'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.teal,
                  shadows: [Shadow(color: Colors.black38)],
                ),
              ), // Ícone de pessoa
              const SizedBox(height: 20), // Adicionando um espaçamento
              //
              //
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                          readOnly: false,
                          decoration: const InputDecoration(
                            labelText: 'Nome do Usuário',
                            prefixIcon: Icon(Icons.person_outline_rounded,
                                color: Colors.teal),
                            border: OutlineInputBorder(),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: false,
                          decoration: const InputDecoration(
                            labelText: 'Nome Completo',
                            prefixIcon: Icon(Icons.person, color: Colors.teal),
                            border: OutlineInputBorder(),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: false,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(Icons.email, color: Colors.teal),
                            border: OutlineInputBorder(),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: false,
                          decoration: const InputDecoration(
                            labelText: 'Contacto ',
                            prefixIcon: Icon(Icons.phone, color: Colors.teal),
                            border: OutlineInputBorder(),
                          ),
                          initialValue: '+258 4958567643'),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Localização',
                          border: OutlineInputBorder(),
                          prefixIcon:
                              Icon(Icons.location_on, color: Colors.teal),
                        ),
                        value: _selectedLocation,
                        items: locations.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            _selectedDistrict = null;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      if (_selectedLocation != null)
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Distrito',
                            border: OutlineInputBorder(),
                            prefixIcon:
                                Icon(Icons.location_city, color: Colors.teal),
                          ),
                          value: _selectedDistrict,
                          items: districts[_selectedLocation!]!
                              .map((String district) {
                            return DropdownMenuItem<String>(
                              value: district,
                              child: Text(district),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedDistrict = newValue;
                            });
                          },
                        ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: false,
                        decoration: const InputDecoration(
                          labelText: 'Área de Atuação',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.work, color: Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: false,
                          decoration: const InputDecoration(
                            labelText: 'Experiência Profissional',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.bookmarks_outlined,
                                color: Colors.teal),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: false,
                        decoration: const InputDecoration(
                          labelText: 'Portfólio (opcional)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.photo,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              //
              //
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text(
                    'Disponibilidade:',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _availability,
                    onChanged: (value) {
                      setState(() {
                        _availability = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Navegue para o formulário de cadastro de cliente
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PerfilProfissional()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Cor de fundo do botão
                          padding: const EdgeInsets.all(13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Editar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white, // Cor do texto do botão
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Navegue para o formulário de cadastro de profissional
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PerfilProfissional()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.all(13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
