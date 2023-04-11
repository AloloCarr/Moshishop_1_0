// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, use_function_type_syntax_for_parameters, unused_element, unused_local_variable, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:moshi_movil_app/provider/agregarAlCarrito_provider.dart';
import 'package:moshi_movil_app/provider/compra_provider.dart';
import 'package:moshi_movil_app/provider/favoritos_provider.dart';

import 'package:moshi_movil_app/provider/productos_provider.dart';
import 'package:moshi_movil_app/screens/detallesdeelproducto.dart';
import 'package:moshi_movil_app/widgets/config_Responsive.dart';

import 'package:provider/provider.dart';

Map<String, bool> favorites = {}; // mapa para almacenar los favoritos

bool isLiked = false;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return ChangeNotifierProvider(
      create: (context) => ProductosProvider()..fetchProductos(),
      child: Scaffold(
        body: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Consumer<ProductosProvider>(
                        builder: (context, productosProvider, _) {
                          return Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 180, 105, 193)),
                                ),
                                onPressed: () async {
                                  final productos =
                                      await productosProvider.fetchProductos();
                                },
                                child: Text('TODOS'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 180, 105, 193)),
                                ),
                                onPressed: () async {
                                  final productos = await productosProvider
                                      .obtenerProductosPorCategoria('pines');
                                },
                                child: Text('Pines'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 180, 105, 193)),
                                ),
                                onPressed: () async {
                                  final productos = await productosProvider
                                      .obtenerProductosPorCategoria('juguete');
                                },
                                child: Text('Juguete'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 180, 105, 193)),
                                ),
                                onPressed: () async {
                                  var productos = await productosProvider
                                      .obtenerProductosPorCategoria('taza');
                                },
                                child: Text('Taza'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 180, 105, 193)),
                                ),
                                onPressed: () async {
                                  var productos = await productosProvider
                                      .obtenerProductosPorCategoria('camisa');
                                },
                                child: Text('Camisa'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 180, 105, 193)),
                                ),
                                onPressed: () async {
                                  var productos = await productosProvider
                                      .obtenerProductosPorCategoria('libro');
                                },
                                child: Text('Libro'),
                              ),
                              SizedBox(width: 10),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<ProductosProvider>(
                builder: (context, productoProvider, child) => productoProvider
                        .isLoanding
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: productoProvider.productos?.length,
                          itemBuilder: (context, index) {
                            final PROD = productoProvider.productos?[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: SizeConfig.blockSizeVertical(40),
                                child: Card(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductoDetails(
                                                        producto: PROD!)),
                                          );
                                        },
                                        child: SizedBox(
                                          height: 150.0,
                                          width: 150.0,
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(20.0),
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${PROD?.imagen}'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '${PROD?.nombre}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 100.0,
                                                      child: Text(
                                                        'Precio: ${PROD?.precio}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15.0,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      /* Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductosPage(
                                                    ProductoCodigo:
                                                        '${PROD?.codigo}',
                                                    imagen: '${PROD?.imagen}',
                                                    precio: '${PROD?.precio}',
                                                    nombre: '${PROD?.nombre}',
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.deepPurpleAccent,
                                            ),
                                            child: Text('Comprar Ahora'),
                                          ),                                        
                                        ],
                                      )*/
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
