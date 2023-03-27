// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:moshi_movil_app/provider/verCarrito_Provider.dart';
import 'package:moshi_movil_app/widgets/config_Responsive.dart';
import 'package:provider/provider.dart';

class CarritoCompra extends StatefulWidget {
  const CarritoCompra({Key? key}) : super(key: key);

  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  late CarritoCompratraer _carritoProvider;

  @override
  void initState() {
    super.initState();
    _carritoProvider = CarritoCompratraer();
    _carritoProvider.fechtCarrito(context);
  }

  @override
  void dispose() {
    _carritoProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);

    return ChangeNotifierProvider.value(
      value: CarritoCompratraer()..fechtCarrito(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CARRITO DE COMPRA'),
        ),
        body: SizedBox(

          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CarritoCompratraer>(
              builder: (context, carritoCompraTraer, child) =>
                  carritoCompraTraer.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: carritoCompraTraer.carritoprod?.length,
                          itemBuilder: (context, index) {
                            final carrito =
                                carritoCompraTraer.carritoprod?[index];
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
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/img/logo.png'),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text('${carrito?.nombre}'),
                                        subtitle: Column(
                                          children: [
                                            Text(
                                                '${carrito?.descripcion}'),
                                            Text(carrito!.precio)
                                          ],
                                        ),
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
          
        ),
      ),
    );
  }
}
