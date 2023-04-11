// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MetodosDePagos extends StatelessWidget {
  const MetodosDePagos({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elige tu método de pago'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 300,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/logo-Paypal.png'),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
                ElevatedButton(
                  onPressed: () {
                    // acción cuando se presiona el botón
                  },
                   style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                  child: const Text('Pagar con PayPal'),
                ),
              ],
            ),
            const SizedBox(height: 200), // espacio entre las imágenes
            Column(
              children: [
                Container(
                  width: 300,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/Oxxo_Logo.svg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // acción cuando se presiona el botón
                  },
                   style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                  
                  child: const Text('Pagar con OXXO'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
