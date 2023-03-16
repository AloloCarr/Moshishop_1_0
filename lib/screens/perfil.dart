// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map<String, dynamic> _user = {};

  Future<Map<String, dynamic>> getUserEmail(String correo) async {
    final response = await http.get(Uri.parse(
        'https://moshishop.up.railway.app/usuarios/buscaruser/$correo'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final user = await getUserEmail('palmaalonzokarelyguadalupe@gmail.com');
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _user.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: const CircleAvatar(
                        backgroundImage: NetworkImage(''), radius: 100),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        // acción al presionar el botón
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .deepPurpleAccent, // Establece el color de fondo
                      ),
                      child: Text('Editar Foto'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text('Usuario:'),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '${_user['nombre']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text('Correo Electronico: '),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '${_user['correo']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text('Telefono: '),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '${_user['telefono']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        // acción al presionar el botón
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .deepPurpleAccent, // Establece el color de fondo
                      ),
                      child: Text('Guardar Cambios'),
                    ),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
      // floatingActionButton: FloatingActionButton(
      // onPressed: loadUser,
      // child: Icon(Icons.refresh),
      // ),
    );
  }
}
