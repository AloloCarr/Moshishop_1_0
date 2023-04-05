import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({Key? key}) : super(key: key);

  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  List<dynamic> productos = [];

  @override
  void initState() {
    super.initState();
    obtenerFavoritos();
  }

  Future<void> obtenerFavoritos() async {
    final preference = await SharedPreferences.getInstance();
    final url = Uri.parse('https://moshishopappi.fly.dev/favorite/gettfav');
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': preference.getString('token')!
    };
    final response = await http.get(url, headers: headers);
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && jsonResponse['favoritos'] != null) {
      setState(() {
        productos = jsonResponse['favoritos'];
      });
      print(jsonResponse);
    } else {
      print('respuesta del servidor: $jsonResponse');
      throw Exception('Error al obtener los productos favoritos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (BuildContext context, int index) {
          final producto = productos[index];
          return ListTile(
            leading: Image.network(producto['imagen']),
            title: Text(producto['nombre']),
            subtitle: Text(producto['descripcion']),
          );
        },
      ),
    );
  }
}
