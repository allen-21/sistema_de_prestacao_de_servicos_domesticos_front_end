import 'package:flutter/material.dart';
import 'tela_login.dart';

class TelaBoasVindas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
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
              const SizedBox(height: 20),
              const Text(
                'Encontre Serviços Domésticos com Facilidade!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300], 
                  elevation: 3, 
                ),
                
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Iniciar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white, 
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
