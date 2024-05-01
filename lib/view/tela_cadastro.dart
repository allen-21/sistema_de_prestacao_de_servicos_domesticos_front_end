import 'package:flutter/material.dart';
import 'tela_cadastro_cliente.dart';
import 'tela_cadastro_profissional.dart';


class TelaCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[200]!, Colors.teal[400]!],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Escolha o tipo de cadastro:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton(
              onPressed: () {
                    // Navegue para o formulário de cadastro de cliente
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaCadastroCliente()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Cor de fundo do botão
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Cadastro de Cliente',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal[400], // Cor do texto do botão
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'OU',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navegue para o formulário de cadastro de profissional
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaCadastroProfissional()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Cadastro de Profissional',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal[400],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Nota: Profissionais aguardarão aprovação do sistema após submeterem os dados.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
