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
  List<bool> buttonState = [false, false, false];
  List<MaterialColor> buttonColor = [Colors.red, Colors.red, Colors.red,];


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
    // speech = stt.SpeechToText();
    // print(speech);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("설정 화면", style: TextStyle(
          fontFamily: "boorsok",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
        ),
        backgroundColor: Colors.white,
        body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("STT 설정", style: TextStyle(fontWeight: FontWeight.bold)), Switch(
          value: buttonState[0],
          onChanged: (value) {
            setState(() {
              buttonState[0] = value;
            });
          },
        ),
        // TextButton(child: Text("마이크"), onPressed: listen),
          ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("마이크 설정", style: TextStyle(fontWeight: FontWeight.bold)), Switch(
              value: buttonState[1],
              onChanged: (value) {
                setState(() {
                  buttonState[1] = value;
                });
              },
            ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("스피커 설정", style: TextStyle(fontWeight: FontWeight.bold)), Switch(
              value: buttonState[2],
              onChanged: (value) {
                setState(() {
                  buttonState[2] = value;
                });
              },
            ),
            ])
        ],))

    );
  }
}
