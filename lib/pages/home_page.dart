
import 'package:flutter/material.dart';
import 'package:relay_43/pages/chat_page.dart';
import 'package:relay_43/screens/welcome_screen.dart';
import 'package:relay_43/screens/login_screen.dart';
import 'package:relay_43/screens/registration_screen.dart';
import 'package:relay_43/widgets/room_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      title: 'ZZOM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomeStatePage(title: this.title),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
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
          "ZZOM",
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
