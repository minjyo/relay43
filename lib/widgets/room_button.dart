import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:relay_43/pages/chat_page.dart';
import 'package:relay_43/services/database_service.dart';

class RoomButton extends StatelessWidget {
  final Color base_color;
  final Text text;
  final String type;

  RoomButton(this.base_color, this.text, this.type);

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          if (type == "make"){
            return _MakeWidget();
          }
          else if (type == "enter"){
            return _EnterWidget();
          }
          else{
            return _EnterWidget();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.0,
      height: 120.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: base_color,
        ),
        onPressed: () => _displayDialog(context),
        child: text,
      ),
    );
  }
}

class _EnterWidget extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '방 초대코드 입력',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: "초대 코드 입력"),
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        new ElevatedButton(
          child: new Text('확인',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  }
  
}

class _MakeWidget extends StatefulWidget{
  @override
  _MakeFormatState createState() => _MakeFormatState();
  
}

class _MakeFormatState extends State<_MakeWidget>{
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _getGroupId(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return AlertDialog(
              title: Text(
                '방 생성 중입니다',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              actions: <Widget>[
                new ElevatedButton(
                  child: new Text(
                      '확인', style: TextStyle(fontWeight: FontWeight.bold,)),
                  onPressed: () => {},
                )
              ],
            );
          }
          else {
            String email = FirebaseAuth.instance.currentUser!.email!;
            
            return AlertDialog(
              title: Text(
                '방 초대 코드',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              content: Text(
                snapshot.data.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              actions: <Widget>[
                new ElevatedButton(
                  child: new Text(
                      '입장하기', style: TextStyle(fontWeight: FontWeight.bold,)),
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        ChatPage(groupId: snapshot.data.toString(), userName: email,)))
                  },
                )
              ],
            );
          }
        }
      );
  }
  
  Future<String> _getGroupId() {
    String? email = FirebaseAuth.instance.currentUser!.email;
    
    return DatabaseService().createGroup(email!)
    .then((groupId){
      return groupId;
    });
    
  }
}