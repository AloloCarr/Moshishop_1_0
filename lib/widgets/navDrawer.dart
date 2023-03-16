// ignore_for_file: file_names, recursive_getters, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:moshi_movil_app/screens/carrito.dart';
import 'package:moshi_movil_app/screens/configuracion.dart';
import 'package:moshi_movil_app/screens/favoritos.dart';
import 'package:moshi_movil_app/screens/home_pages.dart';
import 'package:moshi_movil_app/screens/login_screen.dart';
import 'package:moshi_movil_app/screens/perfil.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  NavDraweState createState() => NavDraweState();
}

class NavDraweState extends State<NavDrawer> {
  int _selectDrawerItem = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomePage();
      case 1:
        return const FavoritosPage();
      case 2:
        return const CarritoCompra();
      case 3:
        return UserScreen();
      case 4:
        return const SettingsPage();
      case 5:
        return; //const LoginScreen();
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOSHISHOP'),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 168, 33, 198)),
              accountName: Text('Bienvenido a Moshishop'),
              accountEmail: Text('¿A donde quieres ir?'),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 220, 146, 234),
                  child: Image(
                    image: AssetImage('assets/img/logo.png'),
                    fit: BoxFit.cover,
                  )),
            ),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.home_outlined),
              selected: (0 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: const Text('Favoritos'),
              leading: const Icon(Icons.star_border_purple500),
              selected: (1 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: const Text('Carrito de compras'),
              leading: const Icon(Icons.shopping_cart_rounded),
              selected: (2 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                _onSelectItem(2);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Perfil'),
              leading: const Icon(Icons.account_circle_rounded),
              selected: (3 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                _onSelectItem(3);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Configuraciones'),
              leading: const Icon(Icons.settings),
              selected: (4 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                _onSelectItem(4);
              },
            ),
            ListTile(
              title: const Text('Cerrar sesion'),
              leading: const Icon(Icons.exit_to_app_rounded),
              selected: (5 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectDrawerItem),
    );
  }
}
