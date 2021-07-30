
import 'package:flutter/material.dart';
import 'package:relay_43/pages/chat_page.dart';


class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title});
  
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Test",
        home: MyHomeStatePage(title: this.title)
    );
  }
}

class MyHomeStatePage extends StatefulWidget {
  MyHomeStatePage({Key? key, required this.title});

  final String title;
  
  @override
  MyHomeStatePageState createState() => MyHomeStatePageState();
}

class MyHomeStatePageState extends State<MyHomeStatePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(groupId: "KdZCkPfkXvdzyibD3aoP", userName: "test",)))
            }, child: Text("테스트 채팅방"),),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
