import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MOSHISHOP', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}