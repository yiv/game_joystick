import 'package:flutter/material.dart';
import 'package:game_joystick/game_joystick.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Container(
                width: 300,
                height: 300,
                child: Joystick(
                  lineColor: Colors.black,
                  lineWidth: 10,
                  verticalController: true,
                  horizontalController: true,
                  // onChanged: (x, y){
                  //   print("onChangedCallback $x - $y");
                  // },
                ))),
      ),
    );
  }
}
