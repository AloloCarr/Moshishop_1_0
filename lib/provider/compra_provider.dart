// ignore_for_file: no_logic_in_create_state, use_build_context_synchronously, prefer_const_constructors, unused_element, library_private_types_in_public_api, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductosPage extends StatefulWidget {
  final String ProductoCodigo;

  const ProductosPage({super.key, required this.ProductoCodigo});
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final TextEditingController UsuarioCorreo = TextEditingController();

  @override
  void dispose() {
    UsuarioCorreo.dispose();
    super.dispose();
  }

  int unidades = 1;
  Future<bool> comprarProductos(
      int unidades, String ProductoCodigo, String UsuarioCorreo) async {
    //final Logger = Logger();
    print("el producto seleccionado es: $ProductoCodigo");
    print("EL USUARIO ES $UsuarioCorreo");
    final response = await http.post(
        Uri.parse('https://moshishop.up.railway.app/compras/agregar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          
        },
        body: jsonEncode(<String, dynamic>{
          'unidades': unidades,
          'ProductoCodigo': ProductoCodigo,
          'UsuarioCorreo': UsuarioCorreo,
          'total': '',
        }));

    //print(response.body);
    if (response.statusCode == 200) {
      //final jsonResponse = jsonDecode(response.body);
      return true;
    } else {
      final jsonResponse = jsonDecode(response.body);
      print(response.body);
      print('Respuesta del servidor: $jsonResponse');
      throw Exception('Ha ocurrido un error al comprar el producto.');
    }
  }

  void _handleBuyButtonPressed() async {
    final success = await comprarProductos(
        unidades, widget.ProductoCodigo, UsuarioCorreo.text);

    if (success) {
      // Actualizar información de la compra en la aplicación.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Producto comprado exitosamente.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Producto sin stock.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Detalles de la compra'),
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
                      )),
                ),
                SizedBox(height: 30),
                Text(
                  'Producto:  ${widget.ProductoCodigo}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // hace el texto en negrita
                    fontSize: 16,
                    fontStyle: FontStyle
                        .normal, // aumenta el tamaño de fuente en 2 puntos
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: UsuarioCorreo,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    hintText: 'Ingrese su correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (unidades > 1) {
                            unidades--;
                          }
                        });
                      },
                      icon: Icon(Icons.remove_circle_outline_outlined),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(unidades.toString()),
                    SizedBox(width: 16),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          unidades++;
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
                    backgroundColor:
                        Colors.deepPurpleAccent, // Establece el color de fondo
                  ),
                  child: Text('Comprar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
