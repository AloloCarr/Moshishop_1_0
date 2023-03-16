import 'package:flutter/material.dart';
import 'package:moshi_movil_app/widgets/icon_person.dart';
import 'package:moshi_movil_app/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context,) {
    final size =
        MediaQuery.of(context).size; //paraobtener el tamaño de la pantalla
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: Center(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(63, 63, 156, 1),
                    Color.fromRGBO(125, 70, 170, 1),
                    Color.fromRGBO(120, 92, 235, 1),
                    Color.fromRGBO(59, 59, 213, 1),
                  ],
                ),
              ), 
              child: SingleChildScrollView( 
                child: Stack( 
                  children:const [ 
                  IconPerson(),
                  LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
