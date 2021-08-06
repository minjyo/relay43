import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:relay_43/pages/chat_page.dart';
import 'package:relay_43/pages/setting_page.dart';

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
  DateTime? currentBackPressTime;

  // 뒤로가기키를 제어하는 함수
  Future<bool> _onBackPressed(){
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)){
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "한번 더 누르면 종료합니다.");
      return Future.value(false);
    }
    return Future.value(true);
  }
  
  @override
  Widget build(BuildContext context) {
    Text textSet(content) {
      return Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }

    // WillPopScope, 뒤로가기 키를 제어할 수 있도록 함
    return WillPopScope(
      onWillPop: _onBackPressed,
      child:Scaffold(
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

                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          SettingPage()));
                    },
                  ),
                 ]
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
      ),
    );
  }
}
