
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:relay_43/pages/chat_page.dart';
import 'package:relay_43/services/database_service.dart';



class RoomEnterDialog extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

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
        // keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 붙여넣기 버튼
              ElevatedButton(
                onPressed: (){
                  Clipboard.getData(Clipboard.kTextPlain).then((value){
                    _textFieldController.text = value!.text!;
                  });
                },
                child: new Text('Paste', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              // 입력창 Clear 버튼
              ElevatedButton(
                onPressed: (){_textFieldController.clear();},
                child: new Text('Clear', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              // 채팅방 입장 버튼
              ElevatedButton(
                child: new Text('확인', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () async {
                  String email = FirebaseAuth.instance.currentUser!.email!;
                  bool flag = await _databaseService.groupExists(_textFieldController.text);

                  if (flag == true){
                    Navigator.of(context).pop();
                    _databaseService.joinGroup(_textFieldController.text, email);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        ChatPage(groupId: _textFieldController.text, userName: email,)));
                  }
                  else{
                    Fluttertoast.showToast(msg: "방이 존재하지 않습니다.");
                    _textFieldController.text = "";
                  }
                },
              )
            ]
        )
      ],
    );
  }

}