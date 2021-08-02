
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:relay_43/pages/chat_page.dart';
import 'package:relay_43/services/database_service.dart';



class RoomMakeDialog extends StatefulWidget{
  @override
  _MakeFormatState createState() => _MakeFormatState();

}

class _MakeFormatState extends State<RoomMakeDialog>{
  final DatabaseService _databaseService = DatabaseService();

  Future<String> _getGroupId() async {
    String? email = FirebaseAuth.instance.currentUser!.email;

    return await _databaseService.createGroup(email!);
  }
  
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _getGroupId(),
        builder: (context, AsyncSnapshot snapshot) {
          // 방을 제작중이거나 에러가 발생한 경우
          if (snapshot.hasData == false || snapshot.hasError == true) {
            return AlertDialog(
              title: Text(
                snapshot.hasError ? "문제 발생" : '방 생성 중입니다',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              actions: <Widget>[
                new ElevatedButton(
                  child: new Text('확인', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            );
          }
          // 방이 만들어진 경우
          else {
            String email = FirebaseAuth.instance.currentUser!.email!;
            String groupId = snapshot.data.toString(); // 방 입장 코드

            return AlertDialog(
              title: Text(
                '방 초대 코드',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              content: Text(
                groupId,
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
                      child: new Text('나가기', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        _databaseService.exitGroup(groupId, email);
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: new Text('COPY', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () => {
                        Clipboard.setData(ClipboardData(text: groupId))
                      },
                    ),
                    ElevatedButton(
                      child: new Text('입장하기', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ChatPage(groupId: groupId, userName: email))
                        );
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

}