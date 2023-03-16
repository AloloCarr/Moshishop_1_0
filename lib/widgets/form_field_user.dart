/**
 * 
 * import 'package:flutter/material.dart';

TextEditingController emailController = TextEditingController();

class FormFieldUser extends StatelessWidget {
  const FormFieldUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( 
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          controller: emailController,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              ),
              hintText: 'Usuario@Example.com',
              labelText: 'Correo Electronico',
              prefixIcon: Icon(Icons.mail_outline)),
          validator: (value) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = RegExp(pattern);
            return regExp.hasMatch(value ?? '')
                ? null
                : 'No es un correo valido';
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

 */