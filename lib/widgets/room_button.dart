
import 'package:flutter/material.dart';
import 'package:relay_43/widgets/room_enter_widget.dart';
import 'package:relay_43/widgets/room_make_widget.dart';

class RoomButton extends StatelessWidget {
  final Color baseColor;
  final Text text;
  final String type;

  RoomButton(this.baseColor, this.text, this.type);

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        // 방을 만들던 도중 Dialog 바깥을 클릭해 나가지는 경우를 방지
        barrierDismissible: type == "make" ? false : true,
        builder: (context) {
          if (type == "make"){
            return RoomMakeDialog(); // 방을 만듬
          }
          else{
            return RoomEnterDialog(); // 방에 입장함
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
          primary: baseColor,
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

