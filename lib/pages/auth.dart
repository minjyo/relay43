
import 'package:flutter/material.dart';
import 'package:relay_43/pages/main_page.dart';
import 'package:relay_43/screens/login_screen.dart';
import 'package:relay_43/screens/registration_screen.dart';
import 'package:relay_43/screens/welcome_screen.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomeStatePage(title: this.title),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MainPage.id: (context) => MainPage(title: title),
      },
    );
  }
}
