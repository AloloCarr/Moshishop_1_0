// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:moshi_movil_app/provider/users_providers.dart';
import 'package:provider/provider.dart';

class PrefilPage extends StatelessWidget {
  const PrefilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Consumer<UserProvider>(
          builder: (context, loginUser, child) => loginUser.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    children: [
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 220, 146, 234),
                            radius: 100,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/img/logo.png',
                                fit: BoxFit.cover,
                                height: 350,
                                width: 350,
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
                                userInfo.nombre,
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
                          child: Text('Correo Electrónico: '),
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
                                userInfo.correo,
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
                          child: Text('Teléfono: '),
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
                                userInfo.telefono,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: Text('Dirección: '),
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
                                userInfo.Direccion,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                      ])
                    ],
                  ),
                )),
    );
  }
}
