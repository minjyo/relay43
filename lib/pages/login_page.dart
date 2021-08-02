
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay_43/pages/main_page.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  User? loggedInUser;
  String? email;
  String? password;

  String makeLoginErrorMessage(String e) {
    String message = "";
    switch (e) {
      case "[firebase_auth/invalid-email] The email address is badly formatted.":
        message = "잘못된 이메일 형식입니다.";
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
              Text(
                "Log In",
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
                    border: OutlineInputBorder(), labelText: "Email"),
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
                    child: Text("Log In"),
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
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, MainPage.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        var msg = makeLoginErrorMessage(e.toString());
                        print(e);
                        setState(() {
                          showSpinner = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(msg),
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
