import 'package:flutter/material.dart';
import 'tela_login.dart';

class TelaBoasVindas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                'Encontre Serviços Domésticos com Facilidade!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navegue para a tela de login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaLogin()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300], // Cor do botão
                  elevation: 3, // Altura da sombra    
                ),
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Iniciar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white, // Cor do texto no botão
                    ),
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

