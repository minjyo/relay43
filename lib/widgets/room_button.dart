import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class RoomButton extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();
  final Color base_color;
  final Text text;

  RoomButton(this.base_color, this.text);

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
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
