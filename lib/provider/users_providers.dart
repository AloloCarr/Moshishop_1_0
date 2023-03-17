// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moshi_movil_app/models/user_login_dto.dart';
import 'package:moshi_movil_app/models/user_sing_up_dto.dart';
import 'package:moshi_movil_app/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:moshi_movil_app/screens/login_screen.dart';
import 'package:moshi_movil_app/widgets/navDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final logger = Logger();
  UserLoginDto? _user;
  UserSingUpDto? _singupUser;
  bool isLoading = true;
  bool userFound = false;
  UserLoginDto? get user => _user;
  UserSingUpDto? get singupUser => _singupUser;

  Future loginUser(String correo, String password, BuildContext context) async {
    final user = UserLoginDto(correo: correo, password: password);

    final response = await http.post(
        Uri.parse('https://moshishop.up.railway.app/usuarios/login'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user));

    print(response.statusCode);

    if (response.statusCode == 200) {
      final userToken = jsonDecode(response.body)[0];
      final preference = await SharedPreferences.getInstance();
      preference.setString('token', userToken);

      print('token: $userToken');
      if (context.mounted) {
        userFound = true;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bienvenido a Moshishop')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const NavDrawer()),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('error')));
      }
    }
  }

  Future singUpUser(String nombre, String correo, String password,
      String telefono, String Direccion, BuildContext context) async {
    final singupUser = UserSingUpDto(
        nombre: nombre,
        correo: correo,
        password: password,
        telefono: telefono,
        Direccion: Direccion);

    final response = await http.post(
      Uri.parse('https://moshishop.up.railway.app/usuarios/registro'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(singupUser),
    );

    if (response.statusCode == 200) {
      if (context.mounted) {
        userFound = true;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registro Exitoso')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen()),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('error')));
      }
    }
  }
}
