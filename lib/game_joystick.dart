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
  double _outlineRadius;
  double _controllerRadius;
  double _padding;
  double _zeroX;
  double _zeroY;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      _padding = 0;
      _controllerRadius = constraints.maxWidth / 8;
      _outlineRadius = constraints.maxWidth / 2;
      _zeroX = _outlineRadius - _controllerRadius - _padding;
      _zeroY = _outlineRadius - _controllerRadius - _padding;
      return GestureDetector(
        onPanEnd: (DragEndDetails details) {
          // print('onPanCancel');
          if (widget.verticalControllerBackToCenter) {
            setState(() {
              _left = _zeroX;
            });
          }
          if (widget.horizontalControllerBackToCenter) {
            setState(() {
              _top = _zeroY;
            });
          }
        },
        onPanUpdate: (DragUpdateDetails details) {
          final _dx = details.localPosition.dx - _outlineRadius - _padding;
          final _dy = details.localPosition.dy - _outlineRadius - _padding;
          final _positionRadius = sqrt(pow(_dx, 2) + pow(_dy, 2));

          if (_positionRadius > (_outlineRadius - _controllerRadius)) {
          // if (false) {
            final _tangent = _dy.abs() / _dx.abs();
            _left = sqrt(pow(_outlineRadius - _controllerRadius, 2) /
                (pow(_tangent, 2) + 1));

            _top = sqrt(pow(_outlineRadius - _controllerRadius, 2) -
                pow(_outlineRadius - _controllerRadius, 2) /
                    (pow(_tangent, 2) + 1));

            if (_dy < 0) {
              _top = -_top - _padding;
            } else {
              _top -= _padding;
            }
            if (_dx < 0) {
              _left = -_left - _padding;
            } else {
              _left -= _padding;
            }
            _top = _top + _outlineRadius - _controllerRadius;
            _left = _left + _outlineRadius - _controllerRadius;

            print(
                'setState#1 dx=$_dx, dy=$_dy, _left=$_left, _top=$_top, _positionRadius=$_positionRadius, _outlineRadius=$_outlineRadius');
          } else {
            _top = details.localPosition.dy - _controllerRadius - _padding;

            _left = details.localPosition.dx - _controllerRadius - _padding;

            print(
                'setState#2 dx=$_dx, dy=$_dy, _left=$_left, _top=$_top, _positionRadius=$_positionRadius, _outlineRadius=$_outlineRadius');
          }

          if (widget.horizontalControllerFixed) {
            _top = _zeroY;
          }
          if (widget.verticalControllerFixed) {
            _left = _zeroX;
          }

          // if (_left != null || _top != null) {
          //   if (widget.horizontalControllerFixed) {
          //     _top = _zeroY;
          //   }
          //   if (widget.verticalControllerFixed) {
          //     _left = _zeroX;
          //   }
          //   print(
          //       'setState#3 dx=$_dx, dy=$_dy, _left=$_left, _top=$_top, _positionRadius=$_positionRadius, _outlineRadius=$_outlineRadius');
          // }

          setState(() {
            _top = _top;
            _left = _left;
          });

          // print(
          //     'setState _outlineRadius=$_outlineRadius, _controllerRadius=$_controllerRadius, _padding=$_padding, _zeroX=$_zeroX, _zeroY$_zeroY');
          // print(
          //     'DragUpdateDetails position=${details.localPosition}, x=${details.localPosition.dx}, y=${details.localPosition.dy}, width=${constraints.maxWidth}');
        },
        child: Container(
          child: Stack(alignment: Alignment.center, children: [
            JoystickOutline(
                lineColor: widget.lineColor, lineWidth: widget.lineWidth),
            widget.verticalController
                ? Container(
                    // color: Colors.pink,
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
                    // color: Colors.green,
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
            Positioned(
              top: _top,
              left: _left,
              child: Icon(
                Icons.circle,
                size: constraints.maxWidth / 4,
                color: widget.lineColor,
                // color: Colors.purple,
              ),
            ),
          ]),
        ),
      );
    });
  }
}
