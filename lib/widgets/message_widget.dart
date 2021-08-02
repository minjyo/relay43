import 'package:flutter/material.dart';

// 채팅방에서 사용하는 메시지 위젯
class MessageWidget extends StatelessWidget {

  final String message;
  final String sender;
  final bool sentByMe;

  MessageWidget(this.message, this.sender, this.sentByMe);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: sentByMe ? 0 : 24,
          right: sentByMe ? 24 : 0),
      // 내가 보낸 것이면 오른쪽, 상대가 보낸 것이면 왼쪽에 배열
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sentByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: sentByMe ? 
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            )
                :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)
            ),
          color: sentByMe ? Colors.blueAccent : Colors.blue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sentByMe ? SizedBox(height: 0.0) : Text(sender, textAlign: TextAlign.start, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: -0.5)),
            sentByMe ? SizedBox(height: 0.0) : SizedBox(height: 7.0),
            Text(message, textAlign: TextAlign.start, style: TextStyle(fontSize: 15.0, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
