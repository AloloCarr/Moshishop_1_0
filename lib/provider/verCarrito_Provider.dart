// ignore_for_file: use_build_context_synchronously, avoid_print, file_names, unused_local_variable, unrelated_type_equality_checks, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moshi_movil_app/dtos/responses/Carrito_response_dtos.dart';
import 'package:moshi_movil_app/screens/carrito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarritoItem {
  final double pay;
  final String nombre;
  final String precio;
  final String descripcion;
  final String imagen;

  CarritoItem({
    required this.pay,
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.imagen,
  });
}

class CarritoCompratraer extends ChangeNotifier {
  double _pay = 0.0;
  String _nombre = '';
  String _precio = '';
  String _descripcion = '';
  double _paytotal = 0.0;
  bool isLoading = true;

  List<CarritoItem>? _carritoprod;
  List<CarritoItem>? get carritoprod => _carritoprod;

  set carritoprod(List<CarritoItem>? value) {
    _carritoprod = value;
    notifyListeners();
  }

  Future<void> fetchCarrito(BuildContext context) async {
    final preference = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('https://moshishopappi.fly.dev/cart/obtener'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': preference.getString('token')!
      },
    );
        Uri.parse('https://moshishopappi.fly.dev/cart/obtener');
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': preference.getString('token')!
        };

    if (response.statusCode == 200) {
      print(response.body);
      isLoading = false;
      final List<dynamic> data = jsonDecode(response.body)['carrito'];
      List<CarritoItem> carritos = [];
      if (data.isNotEmpty) {
        for (var i = 0; i < data.length; i++) {
          var carrito = CarritoItem(
            pay: data[i]['pay'].toDouble(),
            nombre: data[i]['Producto']['nombre'].toString(),
            precio: data[i]['Producto']['precio'],
            descripcion: data[i]['Producto']['descripcion'].toString(),
            imagen: data[i]['Producto']['imagen'].toString(),
          );
          carritos.add(carrito);
        }
      }
      carritoprod = carritos;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CarritoCompra()),
      );
      print(jsonDecode(response.body));
      _nombre = jsonDecode(response.body)['carrito'][0]['Producto']['nombre'];
      print(_nombre);
      _pay = jsonDecode(response.body)['carrito'][0]['pay'].toDouble();
      print(_pay);
      _precio = jsonDecode(response.body)['carrito'][0]['Producto']['precio'];
      print(_precio);
      _descripcion =
          jsonDecode(response.body)['carrito'][0]['Producto']['descripcion'];
      print(_descripcion);
      _paytotal = jsonDecode(response.body)['paytotal'].toDouble();
      print(_paytotal);
      isLoading = false;
      print(_nombre);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CarritoCompra()));
      notifyListeners();
    }
  }
}


//00000000000000000000000000000000000000000000000000000000000000000000000000000000000
 /* Future<void> eliminarProdCart(String nombre) async {
    final preference = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('https://moshishopappi.fly.dev/cart/eliminar'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': preference.getString('token')!
        },
        body: {
          'nombre': nombre,
        });

    if (response.statusCode == 200) {
      ?.removeWhere((eliminar) => eliminar.carrito == nombre);
      notifyListeners();
    } else {
      throw Exception('No se pudo eliminar el producto');
    }
  }
}
*/