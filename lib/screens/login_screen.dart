import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay_43/pages/main_page.dart';
import 'package:relay_43/screens/welcome_screen.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  User? loggedInUser;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Sign In",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 32.0,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "ID"),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text("Sign In"),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        print("email : $email , password : $password");
                        final dynamic newUser =
                            await _auth.signInWithEmailAndPassword(
                                email: email!, password: password!);
                        if (newUser != null) {
                          Navigator.pushNamed(context, MainPage.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        var msg = e.toString();
                        print(e);
                        setState(() {
                          showSpinner = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(msg),
                            // action: SnackBarAction(
                            //   label: 'Action',
                            //   onPressed: () {
                            //     // Code to execute.
                            //   },
                            // ),
                          ),
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
