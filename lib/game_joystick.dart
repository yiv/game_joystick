import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_joystick/joystick_outline.dart';

class Joystick extends StatefulWidget {
  @override
  _JoystickState createState() => _JoystickState();

  final double lineWidth;
  final Color lineColor;
  final bool horizontalController;
  final bool verticalController;
  final bool horizontalControllerFixed;
  final bool verticalControllerFixed;
  final bool horizontalControllerBackToCenter;
  final bool verticalControllerBackToCenter;

  Joystick(
      {this.lineWidth,
      this.lineColor,
      this.horizontalController = true,
      this.verticalController = true,
      this.horizontalControllerFixed = false,
      this.verticalControllerFixed = false,
      this.horizontalControllerBackToCenter = true,
      this.verticalControllerBackToCenter = true});
}

class _JoystickState extends State<Joystick> {
  double _top;
  double _left;

  @override
  Widget build(BuildContext context) {
    print('edwin 35# ${cos(30)}');
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return GestureDetector(
        // onTap: (){
        //   print('hello tap');
        // },
        onPanEnd: (DragEndDetails details) {
          // print('onPanCancel');
          if (widget.verticalControllerBackToCenter) {
            setState(() {
              _left = constraints.maxWidth / 2 -
                  constraints.maxWidth / 8 -
                  widget.lineWidth / 2;
            });
          }
          if (widget.horizontalControllerBackToCenter) {
            setState(() {
              _top = constraints.maxWidth / 2 -
                  constraints.maxWidth / 8 -
                  widget.lineWidth / 2;
            });
          }
        },
        onPanUpdate: (DragUpdateDetails details) {
          double newTop = details.localPosition.dy - constraints.maxWidth / 8;
          double newLeft = details.localPosition.dx - constraints.maxWidth / 8;
          if (_left != null || _top != null) {
            if (widget.horizontalControllerFixed) {
              newTop = constraints.maxWidth / 2 -
                  constraints.maxWidth / 8 -
                  widget.lineWidth / 2;
            }
            if (widget.verticalControllerFixed) {
              newLeft = constraints.maxWidth / 2 -
                  constraints.maxWidth / 8 -
                  widget.lineWidth / 2;
            }
          }
          setState(() {
            _top = newTop;
            _left = newLeft;
            // print('setState _top=$_top, _left=$_left');
          });
          // print(
          //     'DragUpdateDetails position=${details.localPosition}, x=${details.localPosition.dx}, y=${details.localPosition.dy}, width=${constraints.maxWidth}, newTop=$newTop, newLeft=$newLeft');
        },
        child: Container(
          padding: EdgeInsets.all(widget.lineWidth / 2),
          color: Colors.yellow,
          child: Stack(alignment: Alignment.center, children: [
            widget.verticalController
                ? Container(
                    color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_drop_up_outlined,
                          size: constraints.maxWidth / 4,
                          color: widget.lineColor,
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          size: constraints.maxWidth / 4,
                          color: widget.lineColor,
                        )
                      ],
                    ),
                  )
                : Container(),
            widget.horizontalController
                ? Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_left_outlined,
                          size: constraints.maxWidth / 4,
                          color: widget.lineColor,
                        ),
                        Icon(
                          Icons.arrow_right_outlined,
                          size: constraints.maxWidth / 4,
                          color: widget.lineColor,
                        )
                      ],
                    ),
                  )
                : Container(),
            JoystickOutline(
                lineColor: widget.lineColor, lineWidth: widget.lineWidth),
            Positioned(
              top: _top,
              left: _left,
              child: Container(
                child: Icon(
                  Icons.circle,
                  size: constraints.maxWidth / 4,
                  color: widget.lineColor,
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
