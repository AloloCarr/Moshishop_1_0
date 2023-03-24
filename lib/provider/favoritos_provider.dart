// ignore_for_file: unused_local_variable, avoid_print, unused_element, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddFavorites extends StatefulWidget {
  final String ProductoCodigo;
  const AddFavorites({Key? key, required this.ProductoCodigo})
      : super(key: key);
  @override
  State<AddFavorites> createState() => _AddFavoritesState();



}

class _AddFavoritesState extends State<AddFavorites> {
  Future<bool> agregarAFavoritos(String ProductosCodigo) async {
    print('el producto seleccionado es: $ProductosCodigo');
    final preference = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('https://moshishopappi.fly.dev/favorite/agregarfav'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': preference.getString('token')!
        },
        body: jsonEncode(<String, dynamic>{'ProductoCodigo': ProductosCodigo}));

    if (response.statusCode == 200) {
      return true;
    } else {
      final jsonResponse = jsonDecode(response.body);
      print('Respuesta del Servidor');
      throw Exception('Error al agregar productos a favoritos');
    }
  }

  void _handleaddfavorite() async {
    final succes = await agregarAFavoritos(widget.ProductoCodigo);

    if(succes){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Producto agregado a favoritos.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Producto no se agreggo el producto a categorias.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
