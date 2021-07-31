import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relay_43/screens/welcome_screen.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    String makeRegisterErrorMessage(String e) {
      String message = "";
      switch (e) {
        case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
          message = "이미 존재하는 계정입니다.";
          break;
        case "[firebase_auth/weak-password] Password should be at least 6 characters":
          message = "패스워드는 6글자 이상으로 해주세요.";
          break;
        case "[firebase_auth/invalid-email] The email address is badly formatted.":
          message = "잘못 된 이메일 형식입니다.";
          break;
        default:
      }
      return message;
    }

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
                obscureText: true,
                textAlign: TextAlign.center,
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
                    child: Text("Register"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        print("email : $email , password : $password");
                        final dynamic newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        if (newUser != null) {}
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        String message = makeRegisterErrorMessage(e.toString());
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
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
