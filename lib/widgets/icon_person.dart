import 'package:flutter/material.dart';

class IconPerson extends StatelessWidget {
  const IconPerson({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 140,
        ),
      ),
    );
  }
}

