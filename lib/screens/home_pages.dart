// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';
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
                                      crossAxisCount: 1),
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
                                            Container(
                                              margin:
                                                  const EdgeInsets.all(20.0),
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.purple,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/img/logo.png'),
                                                  )),
                                            ),
                                            ListTile(
                                                title: Text(
                                                    'Nombre: ${PROD?.nombre}'),
                                                subtitle: Text(
                                                    'Precio: ${PROD?.precio}'),
                                                trailing: IconButton(
                                                  icon: Icon(Icons
                                                      .favorite_border_outlined),
                                                  onPressed: () {},
                                                )),
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
                                                              ProductosPage(ProductoCodigo:'${PROD?.codigo}',),
                                                        ));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .deepPurpleAccent, // Establece el color de fondo
                                                  ),
                                                  child: Text('Comprar Ahora'),
                                                ),
                                                SizedBox(
                                                    width:
                                                        20), // Espacio entre los botones
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Acción del segundo botón
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .deepPurpleAccent, // Establece el color de fondo
                                                  ),
                                                  child:
                                                      Text('Añadir a carrito'),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              })))
            ],
          ),
        ),
      ),
    );
  }
}
