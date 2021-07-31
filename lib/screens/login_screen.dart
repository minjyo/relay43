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

  String makeLoginErrorMessage(String e) {
    String message = "";
    switch (e) {
      case "[firebase_auth/invalid-email] The email address is badly formatted.":
        message = "잘못된 이메일 형식입니다";
        break;
      case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
        message = "존재하지 않는 이메일입니다.";
        break;
      case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
        message = "잘못 된 패스워드 입니다.";
        break;
      default:
    }
    return message;
  }

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
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: Text("Log In"),
                    color: Colors.blue,
                    textColor: Colors.white,
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
                        setState(() {
                          showSpinner = false;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String message =
                                makeLoginErrorMessage(e.toString());
                            return AlertDialog(
                              content: new Text(message),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("확인"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
