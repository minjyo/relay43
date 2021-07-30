import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:relay_43/pages/home_page.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyHomePage(title: 'Flutter Demo Home Page');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class Loading extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Loading")
        ),
        body: Column(
          children: [
            Center(
              child: Text("Loading")
            )
          ],
        )
      )
    );
  }
}