import 'package:flutter/material.dart';
import 'package:relay_43/pages/login_page.dart';
import 'package:relay_43/pages/registration_page.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: SizedBox(
                height: 100,
                width: 350,
                child: Text(
                  "ZZom",
                  style: TextStyle(
                      fontFamily: "boorsok",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                      fontSize: 100,
                      color: Colors.blue[400]),
                  textAlign: TextAlign.center,
                ),
              ),
              // child: Image.asset('images/logo.png')),
            ),
            SizedBox(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "INVITE",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "YOUR",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "TEAM",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 3000.0,
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationPage.id);
                      },
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          // fontFamily: "boorsok",
                          letterSpacing: 1.0,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue[400],
                          onPrimary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 3000.0,
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                          // fontFamily: "boorsok",
                          letterSpacing: 1.0,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue[400],
                          onPrimary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
