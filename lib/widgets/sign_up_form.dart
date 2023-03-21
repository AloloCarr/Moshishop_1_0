import 'package:flutter/material.dart';
import 'package:moshi_movil_app/provider/users_providers.dart';
import 'package:moshi_movil_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SingUpForm extends StatefulWidget {
  const SingUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SingUpForm> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool isSecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 210,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          height: 560,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'INICIAR SESION',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Text(
                    ' / ',
                    style: TextStyle(fontSize: 30),
                  ),
                  const Text(
                    'REGISTRO',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      controller: nameController,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          hintText: 'Nombre Completo',
                          labelText: 'Nombre Completo',
                          prefixIcon: Icon(Icons.person_outlined)),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      controller: emailController,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          hintText: 'Usuario@Example.com',
                          labelText: 'Correo Electrónico',
                          prefixIcon: Icon(Icons.mail_outlined)),
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        return regExp.hasMatch(value ?? '')
                            ? null
                            : 'No es un correo valido';
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: isSecurePassword,
                      controller: passwordController,
                      autocorrect: false,
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          hintText: '*******',
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: togglePassword()),
                      validator: (value) {
                        return (value != null && value.length >= 4)
                            ? null
                            : 'La contraseña debe ser mayor o igual a los 4 caracteres';
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autocorrect: false,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          hintText: '999-999-9999',
                          labelText: 'Numero Telefónico',
                          prefixIcon: Icon(Icons.phone_iphone_outlined)),
                      validator: (value) {
                        return (value != null && value.length >= 10)
                            ? null
                            : 'El numero telefónico debe ser mayor o igual a los 10 caracteres';
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autocorrect: false,
                      controller: adressController,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          labelText: 'Dirección',
                          prefixIcon: Icon(Icons.numbers_outlined)),
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                color: Colors.deepPurple,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    context.read<UserProvider>().singUpUser(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        phoneNumberController.text,
                        adressController.text,
                        context);
                  }
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 50,
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
