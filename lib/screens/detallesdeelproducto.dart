// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moshi_movil_app/dtos/responses/Productos_response-dto.dart';
import 'package:moshi_movil_app/provider/agregarAlCarrito_provider.dart';
import 'package:moshi_movil_app/provider/favoritos_provider%20(2).dart';
import 'package:moshi_movil_app/screens/metodosDePago.dart';

class ProductoDetails extends StatelessWidget {
  final ProductosReponseDtos producto;

  const ProductoDetails({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(20.0),
            height: 200, // Establece una altura específica
            width: 200, // Establece un ancho específico
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(producto.imagen),
                fit: BoxFit.cover,
              ),
            ),
          )),
          ListTile(
            title: Text(
              producto.nombre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            trailing: FavoriteButton(productoCodigo: producto.codigo ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categoria:  ${producto.categoriaNombre}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Descripcion: ${producto.descripcion}',
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Precio:  \$${producto.precio}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MetodosDePagos(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                      child: const Text('Comprar Ahora'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCart(
                              ProductoCodigo: producto.codigo,
                              imagen: producto.imagen,
                              nombre: producto.nombre,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                      child: Text('Añadir a carrito'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
