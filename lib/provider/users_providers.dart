// ignore_for_file: avoid_print, non_constant_identifier_names

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
  String _correo = '';
  String _password = '';
  String _nombre = '';
  String _telefono = '';
  String _Direccion = '';

  String get correo => _correo;
  String get password => _password;
  String get nombre => _nombre;
  String get telefono => _telefono;
  String get Direccion => _Direccion;

  set correo(String value) {
    _correo = value;
    ChangeNotifier();
  }

  set password(String value) {
    _password = value;
    ChangeNotifier();
  }

  final logger = Logger();
  UserLoginDto? _user;
  UserSingUpDto? _singupUser;
  bool isLoading = true;
  bool userFound = false;
  UserLoginDto? get user => _user;
Future loginUser(BuildContext context) async {
    if (_correo != '' && _password != '') {
      final response = await http.post(
          Uri.parse('https://moshishop.up.railway.app/usuarios/login'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(
              <String, String>{"correo": _correo, "password": _password}));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final userToken = jsonDecode(response.body)[0];
        final preference = await SharedPreferences.getInstance();
        preference.setString('token', userToken);
        isLoading = false;
        _correo = jsonDecode(response.body)[1]['correo'];
        _password = jsonDecode(response.body)[1]['password'];
        _nombre = jsonDecode(response.body)[1]['nombre'];
        _telefono = jsonDecode(response.body)[1]['telefono'];
        _Direccion = jsonDecode(response.body)[1]['Direccion'];




        print('token: $userToken');
        print(response);
        print(correo);
        print(_correo);
        if (context.mounted) {
          userFound = true;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bienvenido a Moshishop')));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => const NavDrawer()))
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('error')));
        }

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

    print(response.statusCode);

    if (response.statusCode == 200) {
      if (context.mounted) {
        userFound = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Registro Exitoso')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen()),
        );
        print("registro completado con exito");
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('error')));
      }
    }
  }
}
}}