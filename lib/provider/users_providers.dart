import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moshi_movil_app/models/user_login_dto.dart';
import 'package:moshi_movil_app/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:moshi_movil_app/widgets/navDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final logger = Logger();
  UserLoginDto? _user;
  bool isLoading = true;
  bool userFound = false;
  UserLoginDto? get user => _user;


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

      print(userToken);
      if (context.mounted) {
        userFound = true;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bienvenido a Moshishop')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => NavDrawer()),
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
