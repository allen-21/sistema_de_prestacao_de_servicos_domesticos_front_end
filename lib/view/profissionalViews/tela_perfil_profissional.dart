import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_alterar_perfil.dart';

class PerfilProfissional extends StatefulWidget {
  const PerfilProfissional({super.key});

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

class _ProfileScreenState extends State<PerfilProfissional> {
  bool _availability = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Center(
              //   child: Icon(Icons.person, size: 100, color: Colors.teal),
              // ), // Ícone de pessoa
              const SizedBox(height: 20), // Adicionando um espaçamento
              //

// Stack(
              // children: [
              //   CircleAvatar(
              //     radius:   60,
              //     backgroundColor: Color.fromRGBO(254, 0, 0, 0),
              //   ),
              //   Positioned(
              //     right: 0,
              //     child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.p) ,),
              //   )
              //   // child: Icon(Icons.person, size: 100, color: Colors.teal),

              //  // Ícone de pessoa
              // ],
              //   ),
              //
              //
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Nome de Usuário',
                            prefixIcon: Icon(Icons.person, color: Colors.teal),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Nome Completo',
                            prefixIcon: Icon(Icons.person, color: Colors.teal),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(Icons.email, color: Colors.teal),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: true,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.lock, color: Colors.teal),
                          ),
                          initialValue: 'hello'),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Localização',
                          prefixIcon: Icon(Icons.location_on_outlined,
                              color: Colors.teal),
                        ),
                        initialValue: 'Maputo',
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Distrito',
                          prefixIcon: Icon(Icons.location_searching,
                              color: Colors.teal),
                        ),
                        initialValue: 'Kampfumo',
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Área de Atuação',
                          prefixIcon: Icon(Icons.work, color: Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Experiência Profissional',
                            prefixIcon: Icon(Icons.bookmarks_outlined,
                                color: Colors.teal),
                          ),
                          initialValue: 'Rizik Issufo'),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Portfólio (opcional)',
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
                child: ElevatedButton(
                  // onHover: (value) => () {

                  // },
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AlterarPerfil()),
                    );
                  },
                  child: const Text(
                    'Editar Dados',
                    style: TextStyle(color: Colors.blue),
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
