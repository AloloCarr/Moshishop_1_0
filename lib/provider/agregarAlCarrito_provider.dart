// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_declarations, avoid_print, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddCart extends StatefulWidget {
  final String ProductoCodigo;

  const AddCart({Key? key, required this.ProductoCodigo}) : super(key: key);
  @override
  _AddCart createState() => _AddCart();
}

class _AddCart extends State<AddCart> {
  int quantity = 1;
  Future<bool> agregarAlcarrito(int quantity, String ProductoCodigo) async {
    print("el producto seleccionado es: $ProductoCodigo");
    final preference = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('https://moshishop.up.railway.app/cart/agregar'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': preference.getString('token')!
      },
      body: jsonEncode(
        <String, dynamic>{
          'quantity': quantity,
          'ProductoCodigo': ProductoCodigo,
          'pay': '',
        },
      ),
    );
    print('token');
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      final jsonResponse = jsonDecode(response.body);
      print('Respuesta del servidor: $jsonResponse');
      throw Exception('Error al agregar el producto al carrito');
    }
  }

  void _handleAddButtomPressed() async {
    final succes = await agregarAlcarrito(quantity, widget.ProductoCodigo);
    if (succes) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Producto agregado exitosamente.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Producto sin stock.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('AÑADIR AL CARRITO'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: AssetImage('assets/img/logo.png'),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Producto Codigo:  ${widget.ProductoCodigo}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold, // hace el texto en negrita
                fontSize: 16,
                fontStyle:
                    FontStyle.normal, // aumenta el tamaño de fuente en 2 puntos
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                  icon: Icon(Icons.remove_circle_outline_outlined),
                ),
                Text(quantity.toString()),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _handleAddButtomPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                child: Text('Confirmar'))
          ],
        )),
      )),
    );
  }
}
