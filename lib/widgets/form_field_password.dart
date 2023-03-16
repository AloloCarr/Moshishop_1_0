/**
 * 
 * import 'package:flutter/material.dart';
y

class FormFieldPassword extends StatefulWidget {
  const FormFieldPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<FormFieldPassword> createState() => _FormFieldPasswordState();
}

class _FormFieldPasswordState extends State<FormFieldPassword> {
  bool isSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: isSecurePassword,
          controller: passwordController,
          autocorrect: false,
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              ),
              hintText: '*******',
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: togglePassword()),
              validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'La contraseña debe ser o igual a los 6 caracteres';
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

//para el show/hide de las respuestas
  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      icon: isSecurePassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      color: Colors.grey,
    );
  }
}

 */