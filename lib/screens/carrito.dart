// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moshi_movil_app/provider/productos_provider.dart';
import 'package:moshi_movil_app/widgets/config_Responsive.dart';

import 'package:provider/provider.dart';

class CarritoCompra extends StatelessWidget {
  const CarritoCompra({super.key});

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
                               // final PROD = productoProvider.productos?[index];
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: SizeConfig.blockSizeVertical(30),
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://media2.giphy.com/media/xTk9ZvMnbIiIew7IpW/giphy.gif?cid=ecf05e47t8efvz6rmr8c1ov5r8ggkjs0g71746h2dwy4y5wp&rid=giphy.gif&ct=g'),
                                                      fit: BoxFit.scaleDown)),
                                            ),
                                            ListTile(
                                                title: Text(
                                                    'Nombre del Producto'),
                                                subtitle: Text(
                                                    'Precio del articulo'),
                                                trailing: IconButton(
                                                  icon: Icon(Icons
                                                      .delete_rounded),
                                                  onPressed: () {},
                                                )),
                                           
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