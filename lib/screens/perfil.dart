// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moshi_movil_app/provider/users_providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefilPage extends StatefulWidget {
  const PrefilPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PrefilPageState createState() => _PrefilPageState();
}

class _PrefilPageState extends State<PrefilPage> {
  late TextEditingController _nombreController;
  late TextEditingController _correoController;
  late TextEditingController _telefonoController;
  late TextEditingController _direccionController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    final userInfo = Provider.of<UserProvider>(context, listen: false);
    _nombreController = TextEditingController(text: userInfo.nombre);
    _correoController = TextEditingController(text: userInfo.correo);
    _telefonoController = TextEditingController(text: userInfo.telefono);
    _direccionController = TextEditingController(text: userInfo.Direccion);
    _passwordController = TextEditingController(text: userInfo.password);
    super.initState();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, loginUser, child) => loginUser.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
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
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre:',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        readOnly: true,
                        controller: _correoController,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico:',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _telefonoController,
                        decoration: InputDecoration(
                          labelText: 'Teléfono:',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _direccionController,
                        decoration: InputDecoration(
                          labelText: 'Dirección:',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña:',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _nombreController.text = userInfo.nombre;
                              _correoController.text = userInfo.correo;
                              _telefonoController.text = userInfo.telefono;
                              _direccionController.text = userInfo.Direccion;
                              _passwordController.text = userInfo.password;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text('Cancelar'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              actualizarUsuario(
                                _correoController.text,
                                _nombreController.text,
                                _passwordController
                                    .text, // No se actualiza la contraseña, así que se pasa null
                                _telefonoController.text,
                                _direccionController.text,
                              );
                            },
                            child: Text('Guardar cambios'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 184, 83, 202),
        onPressed: () async {
          // Llama a la función que actualiza los datos del usuario
          await actualizarUsuario(
            _correoController.text,
            _nombreController.text,
            _passwordController
                .text, // No se actualiza la contraseña, así que se pasa null
            _telefonoController.text,
            _direccionController.text,
          );

          // Recarga la pantalla para mostrar los datos actualizados
          setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future<void> actualizarUsuario(String correo, String nombre, String password,
      String telefono, String Direccion) async {
    final preference = await SharedPreferences.getInstance();
    final url =
        Uri.parse('https://moshishop.up.railway.app/Usuarios/actualizar');
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': preference.getString('token')!
    };
    final body = jsonEncode({
      'correo': correo,
      'nombre': nombre,
      'password': password,
      'telefono': telefono,
      'Direccion': Direccion,
    });
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Usuario actualizado correctamente');
    } else if (response.statusCode == 404) {
      print('Usuario no encontrado');
    } else {
      print('Error al actualizar el usuario');
    }
  }
}
