
import 'package:flutter/material.dart';
import 'package:relay_43/pages/main_page.dart';
import 'package:relay_43/pages/login_page.dart';
import 'package:relay_43/pages/registration_page.dart';
import 'package:relay_43/pages/welcome_page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomePage.id,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomeStatePage(title: this.title),
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        MainPage.id: (context) => MainPage(title: title),
      },
    );
  }
}
