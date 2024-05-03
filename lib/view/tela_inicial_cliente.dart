import 'package:flutter/material.dart';

class TelaInicialCliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Lógica para navegar para a tela de pesquisa
            },
          ),
          IconButton(
            icon: Icon(Icons.person), // Alteração do ícone para o perfil do usuário
            onPressed: () {
              // Lógica para navegar para o perfil do usuário
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.teal,
              child: Text(
                'Encontrar Profissionais',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para navegar para a categoria selecionada
                    },
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          categorias[index].icone,
                          size: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          categorias[index].titulo,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    label: SizedBox.shrink(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        categorias[index].cor,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20.0),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.teal,
              child: Text(
                'Profissionais em Destaque',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                // Lógica para rolar os profissionais em destaque
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    ...List.generate(
                      5,
                      (index) => Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              color: Colors.grey[300],
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Nome do Profissional $index',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Serviço Oferecido'),
                            Text('Avaliação: 4.5'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), // Alteração do ícone para profissionais
            label: 'Profissionais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket), // Alteração do ícone para o carrinho
            label: 'Serviços Solicitados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Alteração do ícone para o chat
            label: 'Chat',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class Categoria {
  final String titulo;
  final IconData icone;
  final Color cor;

  Categoria({
    required this.titulo,
    required this.icone,
    required this.cor,
  });
}

List<Categoria> categorias = [
  Categoria(
    titulo: 'Limpeza',
    icone: Icons.cleaning_services,
    cor: Colors.blue,
  ),
  Categoria(
    titulo: 'Jardinagem',
    icone: Icons.eco,
    cor: Colors.green,
  ),
  Categoria(
    titulo: 'Encanamento',
    icone: Icons.build,
    cor: Colors.orange,
  ),
  Categoria(
    titulo: 'Eletricidade',
    icone: Icons.flash_on,
    cor: Colors.yellow,
  ),
  Categoria(
    titulo: 'Reparos Gerais',
    icone: Icons.build,
    cor: Colors.red,
  ),
];
