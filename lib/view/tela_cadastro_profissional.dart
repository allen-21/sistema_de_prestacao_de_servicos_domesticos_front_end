import 'package:flutter/material.dart';

class TelaCadastroProfissional extends StatefulWidget {
  @override
  _TelaCadastroProfissionalState createState() =>
      _TelaCadastroProfissionalState();
}

class _TelaCadastroProfissionalState extends State<TelaCadastroProfissional> {
  String? _selectedLocation = null;

  final List<String> locations = [
    'Maputo Cidade',
    'Maputo Província',
  ];

  final Map<String, List<String>> districts = {
    'Maputo Cidade': ['KaMpfumo', 'KaMaxaquene', 'KaMavota', 'KaMubukwana'],
    'Maputo Província': ['Manhiça', 'Matola', 'Boane', 'Namaacha'],
  };

  String? _selectedDistrict = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Profissional'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome de Usuário',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirme a Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Localização',
                  prefixIcon: Icon(Icons.location_on),
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
              SizedBox(height: 20),
              if (_selectedLocation != null)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Distrito',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  value: _selectedDistrict,
                  items: districts[_selectedLocation!]!.map((String district) {
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
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Área de Atuação',
                  prefixIcon: Icon(Icons.work),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Experiência Profissional',
                  prefixIcon: Icon(Icons.work),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Portfólio (opcional)',
                  prefixIcon: Icon(Icons.photo),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Adicione a lógica para submeter os documentos
                },
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text(
                  'Enviar Documentos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Adicione a lógica para enviar o formulário
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Ao clicar em "Cadastrar", você concorda com nossos Termos de Serviço e Política de Privacidade.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Adicione a lógica para abrir os Termos de Serviço
                },
                child: Text(
                  'Termos de Serviço',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Adicione a lógica para abrir a Política de Privacidade
                },
                child: Text(
                  'Política de Privacidade',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
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
