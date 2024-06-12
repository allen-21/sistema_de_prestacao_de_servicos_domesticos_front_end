import 'package:flutter/material.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/bem_vindo.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_lista_pedidos.dart';
import 'package:sistema_de_prestacao_de_servicos_domesticos/view/profissionalViews/tela_adcionar_listar_servicos.dart';
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
      WelcomePage(),
      PerfilProfissional(token: widget.token),
      PedidosProfissionalScreen(token: widget.token),
    //  AddAndListServicesScreen(token: widget.token),
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
        backgroundColor: Color(0xFF075E54),
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
