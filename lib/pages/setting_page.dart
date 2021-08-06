import 'package:flutter/material.dart';
import 'package:relay_43/pages/login_page.dart';
import 'package:relay_43/pages/registration_page.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main_page.dart';

class SettingPage extends StatefulWidget {
  static const String id = 'setting_screen';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<bool> buttonState = [false, false, true];
  List<MaterialColor> buttonColor = [Colors.red, Colors.red, Colors.red,];

  static const APP_ID = 'c2482b6302be4074a79ba3349950aa4a';
  static const Token = '006c2482b6302be4074a79ba3349950aa4aIAAbp/2TdSOvoQ2s1rX0J4wECj8L6H10wg1Dnt9KlBu5AIFLID4AAAAAEAAabyR2CTwOYQEAAQAJPA5h';

  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  //************************* STT ********************//
  // late stt.SpeechToText speech;
  bool _isListening = false;
  String text = 'Press the button and start speaking';
  double _confidence = 1.0;

  void changeState(i){
    buttonState[i] = !buttonState[i];
    buttonColor[i] = buttonState[i] ? Colors.blue : Colors.red;
  }

  // STT
  // listen() async {
  //   if (!_isListening) {
  //     bool available = await speech.initialize(
  //       onStatus: (val) => print('onStatus: $val'),
  //       onError: (val) => print('onError: $val'),
  //     );
  //     print("aaa");
  //     if (available) {
  //       setState(() => _isListening = true);
  //       speech.listen(
  //         onResult: (val) => setState(() {
  //           text = val.recognizedWords;
  //           if (val.hasConfidenceRating && val.confidence > 0) {
  //             _confidence = val.confidence;
  //           }
  //         }),
  //       );
  //     }
  //   } else {
  //     setState(() => _isListening = false);
  //     speech.stop();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // speech = stt.SpeechToText();
    // print(speech);
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
    // return Scaffold(
    //     appBar: AppBar(title: Text("설정 화면", style: TextStyle(
    //       fontFamily: "boorsok",
    //       fontWeight: FontWeight.bold,
    //       fontSize: 20,
    //     ),),
    //     ),
    //     backgroundColor: Colors.white,
    //     body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
    //       children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("STT 설정", style: TextStyle(fontWeight: FontWeight.bold)), Switch(
    //       value: buttonState[0],
    //       onChanged: (value) {
    //         setState(() {
    //           buttonState[0] = value;
    //         });
    //       },
    //     ),
    //     // TextButton(child: Text("마이크"), onPressed: listen),
    //       ])
    //     ],))
    //
    // );
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
