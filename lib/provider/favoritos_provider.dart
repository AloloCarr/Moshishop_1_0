import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final String productoCodigo;

  const FavoriteButton({Key? key, required this.productoCodigo})
      : super(key: key);

  @override
  FavoriteButtonState createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _loadIsLiked();
  }

  Future<void> _loadIsLiked() async {
    final preference = await SharedPreferences.getInstance();
    setState(() {
      isLiked = preference.getBool(widget.productoCodigo) ?? false;
    });
  }

  Future<void> _agregarFavorito() async {
    final preference = await SharedPreferences.getInstance();
    final url = Uri.parse('https://moshishopappi.fly.dev/favorite/agregarfav');
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': preference.getString('token')!
    };
    final body = {'ProductoCodigo': widget.productoCodigo};
    final response =
        await http.post(url, headers: headers, body: json.encode(body));
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        isLiked = true;
      });
      preference.setBool(widget.productoCodigo, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Producto agregado a favoritos'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {},
            textColor: Colors.white,
          ),
        ),
      );
      print(jsonResponse);
    } else {
      if (jsonResponse.containsKey('message') &&
          jsonResponse['message'] == 'El producto ya está en tus favoritos') {
        setState(() {
          isLiked = true;
        });
        preference.setBool(widget.productoCodigo, true);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Producto ya agregado'),
              content: Text(jsonResponse['message']),
              actions: <Widget>[
                TextButton(
                  child: Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('respuesta del servidor: $jsonResponse');
        throw Exception('Error al agregar el producto a favoritos');
      }
    }
  }

  Future<void> _eliminarFavorito() async {
    final preference = await SharedPreferences.getInstance();
    final url = Uri.parse('https://moshishopappi.fly.dev/favorite/eliminar');
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': preference.getString('token')!
    };
    final body = {'ProductoCodigo': widget.productoCodigo};
    final response =
        await http.delete(url, headers: headers, body: json.encode(body));
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        isLiked = false;
      });
      preference.setBool(widget.productoCodigo, false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Producto eliminado de favoritos'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {},
            textColor: Colors.white,
          ),
        ),
      );
      print(jsonResponse);
    } else {
      print('respuesta del servidor: $jsonResponse');
      throw Exception('Error al eliminar el producto de favoritos');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isLiked) {
          _eliminarFavorito();
        } else {
          _agregarFavorito();
        }

        setState(() {
          isLiked = !isLiked;
        });
      },
      icon: isLiked
          ? const Icon(Icons.favorite, color: Colors.red)
          : const Icon(Icons.favorite_border),
    );
  }
}
