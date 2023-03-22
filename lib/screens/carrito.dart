import 'package:flutter/material.dart';
import 'package:moshi_movil_app/provider/verCarrito_Provider.dart';
import 'package:moshi_movil_app/widgets/config_Responsive.dart';

import 'package:provider/provider.dart';

class CarritoCompra extends StatelessWidget {
  const CarritoCompra({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    final cartInfo = Provider.of<CarritoCompratraer>(context);
    return ChangeNotifierProvider.value(
      value: cartInfo,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Carrito'),
        ),
        body: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CarritoCompratraer>(
                builder: (context, cartInfo, child) => cartInfo.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: cartInfo.carritoprod?.length,
                          itemBuilder: (context, index) {
                            final carrito = cartInfo.carritoprod?[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: SizeConfig.blockSizeVertical(40),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(20.0),
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.purple,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: const DecorationImage(
                                              image: NetworkImage(
                                                  'assets/img/logo.png'),
                                            )),
                                      ),
                                      ListTile(
                                        title: Text(cartInfo.nombre),
                                        subtitle: Text(cartInfo.descripcion),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {},
                                        ),
                                      )
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
