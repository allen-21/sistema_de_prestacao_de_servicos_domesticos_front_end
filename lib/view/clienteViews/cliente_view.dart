
import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_lista_solicitacoes.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_perfil_cliente.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/clienteViews/tela_profissao.dart';

class ClientWelcomeScreen extends StatefulWidget {
  final String token;
  const ClientWelcomeScreen({super.key, required this.token});

  @override
  State<ClientWelcomeScreen> createState() => _ClientWelcomeScreenState();
}

class _ClientWelcomeScreenState extends State<ClientWelcomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      PerfilCliente (token:widget.token),
      ProfissaoScreen(token:widget.token),
      ClienteListSolicitaco(token:widget.token)

    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Lista de Profissões',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Pedidios',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
