import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_conversa.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_lista_pedidos.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_lista_servicos.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_perfil_profissional.dart';

class ProfissionalMenu extends StatefulWidget {
  final String token;
  const ProfissionalMenu({Key? key, required this.token}) : super(key: key);

  @override
  State<ProfissionalMenu> createState() => _ProfissionalMenuState();
}

class _ProfissionalMenuState extends State<ProfissionalMenu> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      PerfilProfissional(token: widget.token),
      ListaPedidos(),
      AddAndListServicesScreen(token: widget.token),
      TelaConversa(),
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
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Lista de Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adicionar Serviço',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Conversas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
