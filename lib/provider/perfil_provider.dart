// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Perfil extends StatefulWidget {
  final String customerCorreo;

  const Perfil({super.key, required this.customerCorreo});

  get isLoading => true;

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late Map<String, dynamic> _perfil;
  @override
  void initState() {
    super.initState();
    fetchPerfil();
  }

  Future fetchPerfil() async {
    final response = await http
        .get(Uri.parse('https://moshishop.up.railway.app/usuarios/buscaruser'));

    if (response.statusCode == 200) {
      setState(() {
        _perfil = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
