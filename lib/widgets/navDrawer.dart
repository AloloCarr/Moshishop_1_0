// ignore_for_file: file_names, recursive_getters, prefer_final_fields, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:moshi_movil_app/provider/agregarAlCarrito_provider.dart';
import 'package:moshi_movil_app/provider/compra_provider.dart';
import 'package:moshi_movil_app/provider/verCarrito_Provider.dart';
import 'package:moshi_movil_app/screens/carrito.dart';
import 'package:moshi_movil_app/screens/configuracion.dart';
import 'package:moshi_movil_app/screens/favoritos.dart';
import 'package:moshi_movil_app/screens/home_pages.dart';
import 'package:moshi_movil_app/screens/login_screen.dart';
import 'package:moshi_movil_app/screens/perfil.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  NavDraweState createState() => NavDraweState();
}

class NavDraweState extends State<NavDrawer> {
  String searchQuery = '';
  int _selectDrawerItem = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return  const HomePage();
      case 1:
        //return const FavoritosScreen();
      case 2:
        return const CarritoCompra();
      case 3:
        return const PrefilPage();
      case 4:
        //return const SettingsPage();
      case 5:
        return; //const LoginScreen();
    }
  }

  void _search() {
    setState(() {});
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final carritoInfo = Provider.of<CarritoCompratraer>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MOSHISHOP'),
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                await showSearch<String>(
                  context: context,
                  delegate: _SearchDelegate(searchQuery),
                );
              })
        ],
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
           /* ListTile(
              title: const Text('Favoritos'),
              leading: const Icon(Icons.favorite_border_outlined),
              selected: (1 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                _onSelectItem(1);
              },
            ) */
            ListTile(
              title: const Text('Carrito de compras'),
              leading: const Icon(Icons.shopping_cart_rounded),
              selected: (2 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                carritoInfo.fechtCarrito(context);
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
            /*
             ListTile(
              title: const Text('Favoritos'),
              leading: const Icon(Icons.favorite_border_outlined),
              selected: (1 == _selectDrawerItem),
              selectedColor: Colors.deepPurpleAccent.shade200,
              onTap: () {
                _onSelectItem(1);
              },
            ) */
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

class _SearchDelegate extends SearchDelegate<String> {
  final String searchQuery;

  _SearchDelegate(this.searchQuery);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        close(context, '');
      },
    );
  }

  void navigateToNextScreen(BuildContext context, String codigoProducto, String imagen, String nombre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCart(
          ProductoCodigo: codigoProducto,
          imagen: imagen,
          nombre: nombre,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: buscarPorNombre(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final searchQuery = snapshot.data!;
          // Aquí puedes implementar la lógica de visualización de resultados
          return ListView.builder(
            itemCount: searchQuery.length,
            itemBuilder: (context, index) {
              final producto = searchQuery[index];
              return ListTile(
                leading: Image.network(producto['imagen']),
                title: Text(producto['nombre']),
                subtitle: Text(producto['descripcion']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_checkout_outlined),
                      onPressed: () {
                        navigateToNextScreen(context, producto['codigo'], producto['imagen'], producto['nombre']);
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductosPage(
                                nombre: producto ['nombre'],
                                ProductoCodigo: producto['codigo'],
                                imagen: producto['imagen'],
                               precio: producto['precio']

                              ),
                            ));
                      },
                      icon: const Icon(Icons.shopping_bag),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/5-removebg-preview.png',
                  width: 300,
                  height: 300,
                ),
                Text(
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  //final AssetImage errorImage = const AssetImage('assets/img/trsite.gif');
  Future<List<dynamic>> buscarPorNombre(String nombre) async {
    final response = await http.get(Uri.parse(
        'https://moshishopappi.fly.dev/productos/findbyname?nombre=$query'));

    if (response.statusCode == 200) {
      final searchQuery = json.decode(response.body);
      return searchQuery;
    } else {
      throw ('NINGUN RESULTADO QUE CONCIDA CON SU BUSQUEDA');
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implementar lógica de sugerencias aquí
    return const Scaffold();
  }
}
