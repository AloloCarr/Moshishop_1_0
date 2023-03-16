// To parse this JSON data, do
//
//     final productosReponseDtos = productosReponseDtosFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ProductosReponseDtos productosReponseDtosFromJson(String str) => ProductosReponseDtos.fromJson(json.decode(str));

String productosReponseDtosToJson(ProductosReponseDtos data) => json.encode(data.toJson());

class ProductosReponseDtos {
    ProductosReponseDtos({
        required this.id,
        required this.nombre,
        required this.cantidad,
        required this.precio,
        required this.codigo,
        required this.categoriaNombre,
    });

    final String id;
    final String nombre;
    final int cantidad;
    final String precio;
    final String codigo;
    final String categoriaNombre;

    factory ProductosReponseDtos.fromMap(Map<String, dynamic> json) => ProductosReponseDtos(
        id: json["id"],
        nombre: json["nombre"],
        cantidad: json["cantidad"],
        precio: json["precio"],
        codigo: json["codigo"],
        categoriaNombre: json["CategoriaNombre"],
    );

    factory ProductosReponseDtos.fromJson(Map<String, dynamic> json) => ProductosReponseDtos(
        id: json["id"],
        nombre: json["nombre"],
        cantidad: json["cantidad"],
        precio: json["precio"],
        codigo: json["codigo"],
        categoriaNombre: json["CategoriaNombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "cantidad": cantidad,
        "precio": precio,
        "codigo": codigo,
        "CategoriaNombre": categoriaNombre,
    };
}
