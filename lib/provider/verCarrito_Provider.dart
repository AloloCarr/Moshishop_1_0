// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_final_fields, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moshi_movil_app/screens/carrito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarritoCompratraer extends ChangeNotifier {
  double _pay = 0.0;
  String _nombre = '';
  String _precio = '';
  String _descripcion = '';
  double _paytotal = 0.0;
  bool isLoading = true;

  double get pay => _pay;
  String get nombre => _nombre;
  String get precio => _precio;
  String get descripcion => _descripcion;
  double get paytotal => _paytotal;

  List<CarritoCompratraer>? _carritoprod;
  List<CarritoCompratraer>? get carritoprod => _carritoprod;

  set carritoprod(List<CarritoCompratraer>? value) {
    _carritoprod = value;
    notifyListeners();
  }

  Future fechtCarrito(BuildContext context) async {
    final preference = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('https://moshishopappi.fly.dev/cart/obtener'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': preference.getString('token')!
        });

    print(response.statusCode);
    print('Aqui termina el carrito');
    if (response.statusCode == 200) {
      isLoading = false;
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
      print(nombre);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CarritoCompra()));
      notifyListeners();
    }
  }
}
