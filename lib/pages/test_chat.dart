import 'package:flutter/material.dart';
import 'package:relay_43/pages/login_page.dart';
import 'package:relay_43/pages/registration_page.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main_page.dart';

class TestChatPage extends StatefulWidget {
  static const String id = 'test_chat_screen';

  @override
  _TestChatPageState createState() => _TestChatPageState();
}

class _TestChatPageState extends State<TestChatPage> {
  static const APP_ID = 'c2482b6302be4074a79ba3349950aa4a';
  static const Token = '006c2482b6302be4074a79ba3349950aa4aIAAbp/2TdSOvoQ2s1rX0J4wECj8L6H10wg1Dnt9KlBu5AIFLID4AAAAAEAAabyR2CTwOYQEAAQAJPA5h';

  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Get microphone permission
    await [Permission.microphone].request();

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(APP_ID);
    var engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          setState(() {
            _joined = true;
          });
        }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Join channel with channel name as 123
    await engine.joinChannel(Token, '123', null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agora Audio quickstart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Agora Audio quickstart'),
        ),
        body: Center(
          child: Text('Please chat!'),
        ),
      ),
    );

  }
}
