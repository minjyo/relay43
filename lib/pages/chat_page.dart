
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relay_43/services/database_service.dart';
import 'package:relay_43/widgets/message_widget.dart';



class ChatPage extends StatefulWidget {

  final String? groupId;
  final String? userName;

  ChatPage({this.groupId, this.userName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? _chats;
  TextEditingController messageEditingController = new TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Widget _chatMessages(Function callback){
    return StreamBuilder(
      stream: _chats,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasData) {
          var snapData = snapshot.data;
          
          return Expanded(
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapData!.docs.length,
                itemBuilder: (context, index){
                Map<String, dynamic> data = snapData.docs[index].data() as Map<String, dynamic>;
                return MessageWidget(
                  data["message"] ,
                  data["sender"],
                  widget.userName == data["sender"],
                );
              }
        ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  /*
  메세지를 보내고 리스트를 받아오는 과정이 비동기 과정일 수도 있다는 생각이 들어
  콜백으로 해보려고 만든 함수입니다.
  해보니 제대로 먹히지도 않아서 필요에 따라 지우셔도 됩니다.
  해당 콜백 함수는 _chatMessages(Function callback) 함수에서 사용합니다.
  */
  _scrollCallBack(){

  }
  _sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sender": widget.userName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId!, chatMessageMap);
      setState(() {
        messageEditingController.text = "";
        Future.delayed(Duration(milliseconds: 100), () {
          //500ms 동안 마지막 위치로 애니매이션 효과를 주면서 이동
          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this._chats = DatabaseService().getChats(widget.groupId!);

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupId!, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _chatMessages(_scrollCallBack),
            Divider(
                color: Colors.black,
                thickness: 1,
            ),
            // Container(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageEditingController,
                        style: TextStyle(
                            color: Colors.black87
                        ),
                        decoration: InputDecoration(
                            hintText: "Send a message ...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),

                    SizedBox(width: 12.0),

                    GestureDetector(
                      onTap: () {
                        _sendMessage();
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Center(child: Icon(Icons.send, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}