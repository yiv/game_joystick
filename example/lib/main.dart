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
        body: Center(child: Container(
            color: Colors.grey,
            width: 200,
            height: 200,
            child: Joystick(lineColor: Colors.black, lineWidth: 5, verticalController: true, horizontalController: true,))),
      ),
    );
  }
}
