import 'package:flutter/material.dart';
import 'package:relay_43/screens/login_screen.dart';
import 'package:relay_43/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                "Zzom",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 56,
                    color: Colors.lightBlue),
              ),
            ),
            SizedBox(height: 200),
            SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text("Sign In"),
                )),
            SizedBox(height: 30),
            SizedBox(
                height: 50.0,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  child: Text("Register"),
                ))
          ],
        ),
      ),
    );
  }
}
