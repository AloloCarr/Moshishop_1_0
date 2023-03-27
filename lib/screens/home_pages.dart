// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, use_function_type_syntax_for_parameters, unused_element, unused_local_variable, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:moshi_movil_app/provider/agregarAlCarrito_provider.dart';
import 'package:moshi_movil_app/provider/compra_provider.dart';

import 'package:moshi_movil_app/provider/productos_provider.dart';
import 'package:moshi_movil_app/widgets/config_Responsive.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
    const HomePage({
    Key? key,
  }) : super(key: key);



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
                  builder: (context, productoProvider, child) =>
                      productoProvider.isLoanding
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1),
                                  itemCount: productoProvider.productos?.length,
                                  itemBuilder: (context, index) {
                                    final PROD =
                                        productoProvider.productos?[index];
                                    return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical(40),
                                          child: Card(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.all(
                                                      20.0),
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              '${PROD?.imagen}'))),
                                                ),
                                                ListTile(
                                                  title:
                                                      Text('${PROD?.nombre}'),
                                                  subtitle: Column(
                                                    children: [
                                                      Text(
                                                        'Precio: ${PROD?.precio}',
                                                      ),
                                                      Text(
                                                        'Categoria: ${PROD?.categoriaNombre}',
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(Icons
                                                        .favorite_border_outlined),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Row(
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
                                                                    nombre: '${PROD?.nombre}',
                                                                ProductoCodigo:
                                                                    '${PROD?.codigo}',
                                                                imagen:
                                                                    '${PROD?.imagen}',
                                                                precio:
                                                                    PROD!.precio  ,
                                                              ),
                                                            ));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: Colors
                                                            .deepPurpleAccent, // Establece el color de fondo
                                                      ),
                                                      child:
                                                          Text('Comprar Ahora'),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            20), // Espacio entre los botones
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddCart(
                                                                          nombre: '${PROD?.nombre}',
                                                                          ProductoCodigo:
                                                                              '${PROD?.codigo}',
                                                                          imagen:
                                                                              '${PROD?.imagen}',
                                                                        )));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: Colors
                                                            .deepPurpleAccent, // Establece el color de fondo
                                                      ),
                                                      child: Text(
                                                          'Añadir a carrito'),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                  }),
                            )),
            ],
          ),
        ),
      ),
    );
  }
}
