import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        barrierDismissible: type == "make" ? false : true,
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
      width: 150.0,
      height: 80.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 8.0,
          primary: base_color,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    onPressed: (){
                      Clipboard.getData(Clipboard.kTextPlain).then((value){
                        print(value);
                        _textFieldController.text = value!.text!;
                      });
                    },
                    child: new Text('Paste',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      _textFieldController.clear();
                    },
                    child: new Text('Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  ElevatedButton(
                    child: new Text('확인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      String email = FirebaseAuth.instance.currentUser!.email!;
                      DatabaseService().groupExists(_textFieldController.text)
                          .then( (flag){
                        if (flag == true){
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              ChatPage(groupId: _textFieldController.text, userName: email,)));
                        }
                        else{
                          Fluttertoast.showToast(msg: "방이 존재하지 않습니다.");
                          _textFieldController.text = "";
                        }
                      }
                      )
                          .catchError((err){
                        print(err);
                      });
                    },
                  )
                ]
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
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          else if (snapshot.hasError){
            return AlertDialog(
              title: Text(
                "문제 발생",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              actions: <Widget>[
                new ElevatedButton(
                  child: new Text(
                      '확인', style: TextStyle(fontWeight: FontWeight.bold,)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: new Text(
                          '나가기', style: TextStyle(fontWeight: FontWeight.bold,)),
                      onPressed: () {
                        DatabaseService().exitGroup(snapshot.data.toString(), email);
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: new Text(
                          'COPY', style: TextStyle(fontWeight: FontWeight.bold,)),
                      onPressed: () => {
                        Clipboard.setData(ClipboardData(text: snapshot.data.toString()))
                      },
                    ),
                    ElevatedButton(
                      child: new Text(
                          '입장하기', style: TextStyle(fontWeight: FontWeight.bold,)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ChatPage(groupId: snapshot.data.toString(), userName: email,)));
                      },
                    )
                  ],
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