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
  @override
  Widget build(BuildContext context) {
    final carritoProvider = Provider.of<CarritoCompratraer>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('CARRITO DE COMPRA'),
        ),
        body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer<CarritoCompratraer>(
                        builder: (context, carritoCompraTraer, child) {
                          final carritoProductos = carritoCompraTraer
                                  .carritoprod ??
                              []; // <-- Obtener la lista de productos del carrito
                          return carritoProvider.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : carritoProductos.isEmpty
                                  ? const Center(
                                      child: Text('El carrito está vacío'),
                                    )
                                  : ListView.builder(
                                      itemCount: carritoProductos.length,
                                      itemBuilder: (context, index) {
                                        final carrito = carritoProductos[index];
                                        return SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical(40),
                                          child: Card(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.all(
                                                      20.0),
                                                  width: 200,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        carrito.imagen,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(carrito.nombre),
                                                  subtitle: Text(carrito.descripcion),
                                                  trailing: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    onPressed: () {
                                                      // Mostrar un diálogo de confirmación antes de eliminar el producto
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Eliminar producto'),
                                                            content: const Text(
                                                                '¿Está seguro de que desea eliminar el producto del carrito?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); // Cerrar el diálogo
                                                                },
                                                                child: const Text(
                                                                    'Cancelar'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                //  carritoProvider.eliminarProdCart(
                                                                   //   carrito); // Eliminar el producto del carrito
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); // Cerrar el diálogo
                                                                },
                                                                child: const Text(
                                                                    'Eliminar'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                        },
                        child: Container(),
                      ),
                    ),
                  ],
                ))));
  }
}
