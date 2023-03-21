import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:moshi_movil_app/dtos/responses/Productos_response-dto.dart';

class ProductosProvider extends ChangeNotifier {
  bool isLoanding = true;
  final logger = Logger();

  List<ProductosReponseDtos>? _productos;

  List<ProductosReponseDtos>? get productos => _productos;

  Future fetchProductos() async {
    final response = await http
        .get(Uri.parse('https://moshishop.up.railway.app/productos/buscar'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      logger.d(json);
      final List<dynamic> data = json;
      _productos = data.map((e) => ProductosReponseDtos.fromMap(e)).toList();
      isLoanding = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load productos');
    }
  }

  Future<List<ProductosReponseDtos>> obtenerProductosPorCategoria(String categoriaNombre) async {
  final body = {
    'CategoriaNombre': categoriaNombre,
  };

  final response = await http.post(
    Uri.parse('https://moshishop.up.railway.app/productos/Buscarporcategoria'),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    final productosJson = jsonDecode(response.body);
    final List<dynamic> data = productosJson as List;
    _productos = data.map((e) => ProductosReponseDtos.fromMap(e)).toList();
    notifyListeners(); // Notificar a los listeners que la lista de productos ha sido actualizada
    return _productos!;
  } else {
    throw Exception('Error al obtener los productos por categoría');
  }
}

}
