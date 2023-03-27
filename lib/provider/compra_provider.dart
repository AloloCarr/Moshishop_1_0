// ignore_for_file: no_logic_in_create_state, use_build_context_synchronously, prefer_const_constructors, unused_element, library_private_types_in_public_api, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductosPage extends StatefulWidget {
  final String ProductoCodigo;
  final String imagen;
  final String precio;
  final String nombre;

  const ProductosPage(
      {super.key,
      required this.ProductoCodigo,
      required this.imagen,
      required this.precio,
      required this.nombre});
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
  Future<bool> comprarProductos(int unidades, String ProductoCodigo,
      String UsuarioCorreo, String precio, String nombre) async {
    //final Logger = Logger();
    print("el producto seleccionado es: $ProductoCodigo");
    print("EL USUARIO ES $UsuarioCorreo");
    // final preference = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('https://moshishopappi.fly.dev/compras/agregar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': preference.getString('token')!
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
        unidades, widget.ProductoCodigo, UsuarioCorreo.text, widget.precio, widget.nombre);
    _showDialog(success);
  }

  void _showDialog(bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? 'Compra exitosa' : 'Error'),
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
                  ? 'El producto se compró correctamente.'
                  : 'No hay stock disponible.'),
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
        title: Text('Detalles de la compra'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.network(widget.imagen),
              ),
              SizedBox(height: 30),
              Text(
                'Codigo Producto:  ${widget.ProductoCodigo}',
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
              Text(
                'Producto:  ${widget.nombre}',
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
              SizedBox(
                width: 300.0,
                child: TextFormField(
                  controller: UsuarioCorreo,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    hintText: 'Ingrese su correo electrónico',
                    border: OutlineInputBorder(),
                  ),
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
              Text(
                'Total: \$${(unidades * double.parse(widget.precio)).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
    );
  }
}
