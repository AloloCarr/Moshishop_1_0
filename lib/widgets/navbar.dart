// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:moshi_movil_app/screens/configuracion.dart';
import 'package:moshi_movil_app/screens/favoritos.dart';
import 'package:moshi_movil_app/screens/home_pages.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _MyStateNavBar();
}

class _MyStateNavBar extends State<NavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritosScreen(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda MoshiShop'),
        backgroundColor: Color.fromARGB(255, 188, 27, 217),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Perfil',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuraciones',
          ),*/
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 17, 9, 18),
        onTap: _onItemTapped,
      ),
    );
  }
}


 