import 'package:flutter/material.dart';
import 'package:new_pib_app/views/Equipe/EscolhaEquipe.dart';
import 'package:new_pib_app/views/eventos/eventos.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

import '../../main.dart';
import '../Equipe/details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void updatePage(index) {}

  @override
  void initState() {
    Function refresh = () {
      setState(() {});
    };
    getIt<RouterCustom>().setRefresh(refresh);
    super.initState();
  }

  final List<String> titles = ['Tela inicial', 'Eventos', 'Tela terciária', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),

      appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          title: Text('a'),
          // Botão de hambúrguer
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  // Abra o Drawer
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          )),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            return getIt<RouterCustom>()
                .screens[getIt<RouterCustom>().currentIndex]!;
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/comum.jpg')),
          color: Colors.red,
        ),
        width: MediaQuery.of(context).size.width,
      ),
      // Drawer para o menu de hambúrguer
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: StandardTheme.homeColor,
              ),
              child: Text('Adore'),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                  color: getIt<RouterCustom>().currentIndex == 0
                      ? StandardTheme.homeColor
                      : StandardTheme.badge,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: getIt<RouterCustom>().currentIndex == 0
                          ? Colors.white
                          : Colors.black),
                ),
                leading: Icon(
                  Icons.home_outlined,
                  color: getIt<RouterCustom>().currentIndex == 0
                      ? Colors.white
                      : Colors.black,
                ),
                onTap: () {
                  setState(() {
                    getIt<RouterCustom>().setIndex('home');
                  });
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                  color: getIt<RouterCustom>().currentIndex == 1
                      ? StandardTheme.homeColor
                      : StandardTheme.badge,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                leading: Icon(
                  Icons.calendar_month,
                  color: getIt<RouterCustom>().currentIndex == 1
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text(
                  'Eventos',
                  style: TextStyle(
                      color: getIt<RouterCustom>().currentIndex == 1
                          ? Colors.white
                          : Colors.black),
                ),
                onTap: () {
                  setState(() {
                    getIt<RouterCustom>().setIndex('eventos');
                  });
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                  color: getIt<RouterCustom>().currentIndex == 2
                      ? StandardTheme.homeColor
                      : StandardTheme.badge,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                leading: Icon(
                  Icons.music_note,
                  color: getIt<RouterCustom>().currentIndex == 2
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text(
                  'Músicas',
                  style: TextStyle(
                      color: getIt<RouterCustom>().currentIndex == 2
                          ? Colors.white
                          : Colors.black),
                ),
                onTap: () {
                  setState(() {
                    getIt<RouterCustom>().setIndex('third');
                  });
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                  color: getIt<RouterCustom>().currentIndex == 3
                      ? StandardTheme.homeColor
                      : StandardTheme.badge,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                leading: Icon(
                  Icons.group,
                  color: getIt<RouterCustom>().currentIndex == 3
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text(
                  'Equipe',
                  style: TextStyle(
                      color: getIt<RouterCustom>().currentIndex == 3
                          ? Colors.white
                          : Colors.black),
                ),
                onTap: () {
                  setState(() {
                    getIt<RouterCustom>().setIndex('equipe');
                  });
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                  color: StandardTheme.badge,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListTile(
                leading: Icon(
                  Icons.group,
                  color: Colors.black,
                ),
                title: Text(
                  'Trocar equipe',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: EscolhaEquipe(),
                          type: PageTransitionType.fade));
                },
              ),
            ),
            //         Container(
            //           margin: EdgeInsets.symmetric(horizontal: 14,vertical: 7),
            //           decoration: getIt<RouterCustom>().currentIndex == 0 ? BoxDecoration(color: StandardTheme.homeColor,borderRadius: BorderRadius.all(Radius.circular(15))):BoxDecoration(),
            //
            //           child: ListTile(
            // leading: Icon(Icons.person),
            //             title: const Text('Meu perfil'),
            //             onTap: () {
            //               setState(() {
            //                 getIt<RouterCustom>().currentIndex = 2;
            //               });
            //               // Update the state of the app
            //               // Then close the drawer
            //               Navigator.pop(context);
            //             },
            //           ),
            //         ),
          ],
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tela 1'),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tela 3'),
    );
  }
}

class Menu extends StatefulWidget {
  Menu({super.key, required this.parent});

  BuildContext parent;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu de Hambúrguer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Opção 1'),
            onTap: () {
              // Adicione o código para ação quando a opção 1 for selecionada
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Opção 2'),
            onTap: () {
              // Adicione o código para ação quando a opção 2 for selecionada
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Opção 3'),
            onTap: () {
              // Adicione o código para ação quando a opção 3 for selecionada
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
    ;
  }
}
