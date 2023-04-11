// To parse this JSON data, do
//
//     final carritoReponseDtos = carritoReponseDtosFromMap(jsonString);
// ignore_for_file: file_names

import 'dart:convert';

CarritoReponseDtos carritoReponseDtosFromMap(String str) =>
    CarritoReponseDtos.fromMap(json.decode(str));

String carritoReponseDtosToMap(CarritoReponseDtos data) =>
    json.encode(data.toMap());

class CarritoReponseDtos {
  CarritoReponseDtos({
    required this.carrito,
    required this.paytotal,
  });

  final List<dynamic> carrito;
  final int paytotal;

  factory CarritoReponseDtos.fromMap(Map<String, dynamic> json) =>
      CarritoReponseDtos(
        carrito:
            List<Carrito>.from(json["carrito"].map((x) => Carrito.fromMap(x))),
        paytotal: json["paytotal"],
      );


  Map<String, dynamic> toMap() => {
        "carrito": List<dynamic>.from(carrito.map((x) => x.toMap())),
        "paytotal": paytotal,
      };

  static fromJson(data) {}
}

class Carrito {
  Carrito({
    required this.pay,
    required this.producto,
  });

  final int pay;
  final Producto producto;

  factory Carrito.fromMap(Map<String, dynamic> json) => Carrito(
        pay: json["pay"],
        producto: Producto.fromMap(json["Producto"]),
      );

  Map<String, dynamic> toMap() => {
        "pay": pay,
        "Producto": producto.toMap(),
      };
}

class Producto {
  Producto({
    required this.nombre,
    required this.precio,
    required this.descripcion,
  });

  final String nombre;
  final String precio;
  final String descripcion;

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        nombre: json["nombre"],
        precio: json["precio"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "precio": precio,
        "descripcion": descripcion,
      };
}
