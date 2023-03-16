import 'package:flutter/material.dart';
import 'package:moshi_movil_app/models/user_login_dto.dart';
import 'package:moshi_movil_app/provider/users_providers.dart';
import 'package:moshi_movil_app/screens/login_screen.dart';
import 'package:moshi_movil_app/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';
void main() => runApp(const MyApp());
UserLoginDto? _password;
UserLoginDto? get password => _password;
UserLoginDto? _correo;
UserLoginDto? get correo => _correo;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/regitrationScreen': (context) => const SignUpScreen(),
        },
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
