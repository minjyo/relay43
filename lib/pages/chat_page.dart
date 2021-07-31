
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final ScrollController _userScrollController = ScrollController();

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
      // 오래동안 백그라운드에 있는 경우, 채팅방을 나가도록 함.
      // 강제종료에 대해서는 Flutter 단에서 처리할 방법이 없는 듯 함...
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
          endDrawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 100,
                  child: DrawerHeader(

                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(0),
                    child: Center(
                      child: Text(
                        widget.userName.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Center(
                      child: Text('참여자',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 24.0
                        ),
                      )
                  ),
                ),
                Container(
                    child: FutureBuilder<dynamic>(
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData) {
                            // return Text('$snapshot.data');
                            List snapData = snapshot.data;
                            print(snapData);
                            return ListView.builder(
                                controller: _userScrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapData.length,
                                itemBuilder: (context, index){
                                  String user = snapData[index];
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(user,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),),
                                    ),
                                  );
                                }
                            );
                          }
                          return Container(child: Text('참여자가 없습니다.', style: TextStyle(fontSize: 20),));
                        },
                        future: DatabaseService().getUserInGroup(widget.groupId!, widget.userName!)
                    )
                )
              ],
            ),

          ),
        appBar: AppBar(
          title: Text(widget.groupId!, style: TextStyle(color: Colors.white, fontSize: 18)),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0.0,
            leading: BackButton(
              color: Colors.white,
            ),
            actions: [
              IconButton(
                icon: new Icon(Icons.copy),
                tooltip: '입장 코드 복사',
                onPressed: () => {
                  Clipboard.setData(ClipboardData(text: widget.groupId)),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("입장 코드가 복사되었습니다."),
                    ),
                  ),
                },
              ),
              Builder(
                  builder: (context) =>
                      IconButton(
                        icon: new Icon(Icons.people),
                        tooltip: '참여자 목록',
                        onPressed: () => {
                          Scaffold.of(context).openEndDrawer(),
                        },
                      )
              )
            ]
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