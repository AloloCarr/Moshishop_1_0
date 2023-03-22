// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_declarations, avoid_print, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddCart extends StatefulWidget {
  final String ProductoCodigo;
  final String imagen;

  const AddCart({Key? key, required this.ProductoCodigo, required this.imagen})
      : super(key: key);
  @override
  _AddCart createState() => _AddCart();
}

class _AddCart extends State<AddCart> {
  int quantity = 1;
  bool isLoading = false;

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

  void _handleBuyButtonPressed() async {
    final success = await agregarAlcarrito(quantity, widget.ProductoCodigo);
    _showDialog(success);
  }

  void _showDialog(bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Se Agrego Al carrito' : 'Error'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              success
                  ? Image(
                      image: AssetImage(
                          'assets/img/logo.png')) // Agrega la imagen si la compra fue exitosa
                  : Image(
                      image: AssetImage(
                          'assets/img/logo.png')), // Agrega la imagen de error si no hay stock disponible
              SizedBox(height: 8.0),
              Text(success
                  ? 'El producto se agrego al carrito exitosamente.'
                  : 'Lo siento hubo un error al agregar el producto al carrito'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
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
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imagen),
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
                onPressed: _handleBuyButtonPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                child: Text('Confirmar'))
          ],
        )),
      )),
    );
  }
}
