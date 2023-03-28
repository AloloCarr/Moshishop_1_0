// To parse this JSON data, do
//
//     final favoritos = favoritosFromJson(jsonString);

import 'dart:convert';

FavoritosDto favoritosFromJson(String str) => FavoritosDto.fromJson(json.decode(str));

String favoritosToJson(FavoritosDto data) => json.encode(data.toJson());

class FavoritosDto {
    FavoritosDto({
        required this.usuarioCorreo,
        required this.fav,
    });

    String usuarioCorreo;
    List<Fav> fav;

    factory FavoritosDto.fromJson(Map<String, dynamic> json) => FavoritosDto(
        usuarioCorreo: json["UsuarioCorreo"],
        fav: List<Fav>.from(json["fav"].map((x) => Fav.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "UsuarioCorreo": usuarioCorreo,
        "fav": List<dynamic>.from(fav.map((x) => x.toJson())),
    };
}

class Fav {
    Fav({
        required this.producto,
    });

    Producto producto;

    factory Fav.fromJson(Map<String, dynamic> json) => Fav(
        producto: Producto.fromJson(json["Producto"]),
    );

    Map<String, dynamic> toJson() => {
        "Producto": producto.toJson(),
    };
}

class Producto {
    Producto({
        required this.nombre,
        required this.precio,
        required this.descripcion,
    });

    String nombre;
    String precio;
    String descripcion;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        nombre: json["nombre"],
        precio: json["precio"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "precio": precio,
        "descripcion": descripcion,
    };
}
