import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relay_43/pages/chat_page.dart';

import 'package:relay_43/widgets/room_button.dart';

class MainPage extends StatelessWidget {
  static const String id = 'home_page';

  MainPage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    // CollectionReference users = FirebaseFirestore.instance.collection('baby');

    // Future<void> _addUser() {
    //   return users
    //       .add({'name': "yjh", "vote": 0})
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }

    Text textSet(content) {
      return Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }

    User? curUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              title: Text(
                widget.title,
                style: TextStyle(
                  fontFamily: "boorsok",
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoomButton(Colors.red[300]!, textSet("방 만들기"), "make"),
              SizedBox(
                width: 30,
              ),
              RoomButton(Colors.blue[300]!, textSet("방 들어가기"), "enter"),
            ],
          ),
        ],
      ),
    );
  }
}
