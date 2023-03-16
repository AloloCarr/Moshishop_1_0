// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> agregarAlcarrito(
    String ProductoCodigo, String quantity, String pay) async {
  final response = await http.post(
    Uri(),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(
      {'ProductoCodigo': ProductoCodigo, 'quantity': quantity, 'pay': ''},
    ),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al agregar el producto al carrito :(');
  }
}
