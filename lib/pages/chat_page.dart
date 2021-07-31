
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

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver{
  Stream<QuerySnapshot>? _chats;
  TextEditingController messageEditingController = new TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  Widget _chatMessages(){
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
                _scrollToBottom();
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

  // 채팅 메시지를 메시지를 보낸다
  _sendMessage({String type = "chat"}) {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sender": widget.userName,
        'time': FieldValue.serverTimestamp(),
        "type": type
      };

      DatabaseService().sendMessage(widget.groupId!, chatMessageMap);
      _scrollToBottom();
      
      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  _scrollToBottom(){
    Future.delayed(Duration(milliseconds: 100), () {
      //500ms 동안 마지막 위치로 애니매이션 효과를 주면서 이동
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.ease);
      },
    );
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    
    DatabaseService().joinGroup(widget.groupId!, widget.userName!);
    setState(() {
      this._chats = DatabaseService().getChats(widget.groupId!);

    });
  }
  
  @override
  void dispose(){
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        DatabaseService().exitGroup(widget.groupId!, widget.userName!);
        Navigator.pop(context);
        break;
      default:
    }
  }
  
  // 뒤로가기 로직 처리
  _onBackPressed(BuildContext context){
    return showDialog( 
        context: context, 
        builder: (context) => AlertDialog( 
          title: Text('채팅방을 나가시겠습니까?'), 
          actions: <Widget>[
            ElevatedButton( 
              child: Text('No'), 
              onPressed: (){
                Navigator.pop(context);
                },
            ), 
            ElevatedButton( 
              child: Text('Yes'),
              onPressed: (){
                DatabaseService().exitGroup(widget.groupId!, widget.userName!);
                
                Navigator.pop(context);
                Navigator.pop(context);
                },
            ),
          ]
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _scrollToBottom());
    
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child:
        Scaffold(
        appBar: AppBar(
          title: Text(widget.groupId!, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              _chatMessages(),
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
                          _sendMessage(type: "chat");
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
      ),
    );
  }

}