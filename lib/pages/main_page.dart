
import 'package:flutter/material.dart';
import 'package:relay_43/pages/chat_page.dart';
import 'package:relay_43/screens/welcome_screen.dart';
import 'package:relay_43/screens/login_screen.dart';
import 'package:relay_43/screens/registration_screen.dart';

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
  void _incrementCounter() {
    setState(() {});
  }

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(groupId: "KdZCkPfkXvdzyibD3aoP", userName: "test",)))
              }, 
              child: Text("테스트 채팅방"),
            ),
            RoomButton(Colors.red[300]!, textSet("방 만들기")),
            SizedBox(
              width: 50,
            ),
            RoomButton(Colors.blue[300]!, textSet("방 들어가기")),
          ],
        ),
      ),
    );
  }
}
