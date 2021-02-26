import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_joystick/joystick_outline.dart';

typedef OnChangedCallback = void Function(double x, double y);

class Joystick extends StatefulWidget {
  @override
  _JoystickState createState() => _JoystickState();

  final double lineWidth;
  final Color lineColor;
  final bool horizontalController;
  final bool verticalController;
  final bool horizontalControllerBackToCenter;
  final bool verticalControllerBackToCenter;
  final OnChangedCallback onChangedCallback;

  Joystick(
      {this.lineWidth,
      this.lineColor,
      this.horizontalController = true,
      this.verticalController = true,
      this.horizontalControllerBackToCenter = true,
      this.verticalControllerBackToCenter = true,
      this.onChangedCallback});
}

class _JoystickState extends State<Joystick> {
  double _top;
  double _left;
  double _outlineRadius;
  double _controllerRadius;
  double _zeroX;
  double _zeroY;
  double _dx;
  double _dy;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      _controllerRadius = constraints.maxWidth / 8;
      _outlineRadius = constraints.maxWidth / 2;
      _zeroX = _outlineRadius - _controllerRadius;
      _zeroY = _outlineRadius - _controllerRadius;
      return GestureDetector(
        onPanEnd: (DragEndDetails details) {
          // print('onPanCancel');
          if (widget.verticalControllerBackToCenter) {
            _dx = 0;
            setState(() {
              _left = _zeroX;
            });
          }
          if (widget.horizontalControllerBackToCenter) {
            _dy = 0;
            setState(() {
              _top = _zeroY;
            });
          }
          widget.onChangedCallback(_dx, _dy);
        },
        onPanUpdate: (DragUpdateDetails details) {
          _dx = details.localPosition.dx - _outlineRadius;
          _dy = -(details.localPosition.dy - _outlineRadius);

          double _cx = _dx;
          double _cy = _dy;

          if (_cx > 0 ){
            _cx = _cx.abs() > _outlineRadius? _outlineRadius: _cx;
          }else{
            _cx = _cx.abs() > _outlineRadius? -_outlineRadius: _cx;
          }
          if (_cy > 0 ){
            _cy = _cy.abs() > _outlineRadius? _outlineRadius: _cy;
          }else{
            _cy = _cy.abs() > _outlineRadius? -_outlineRadius: _cy;
          }

          widget.onChangedCallback(_cx/_outlineRadius, _cy/_outlineRadius);

          final _positionRadius = sqrt(pow(_dx, 2) + pow(_dy, 2));

          if (_positionRadius > (_outlineRadius - _controllerRadius)) {
            // if (false) {
            final _tangent = _dy.abs() / _dx.abs();
            _left = sqrt(pow(_outlineRadius - _controllerRadius, 2) /
                (pow(_tangent, 2) + 1));

            _top = sqrt(pow(_outlineRadius - _controllerRadius, 2) -
                pow(_outlineRadius - _controllerRadius, 2) /
                    (pow(_tangent, 2) + 1));

            if (_dy > 0) {
              _top = -_top;
            }
            if (_dx < 0) {
              _left = -_left;
            }
            _top = _top + _outlineRadius - _controllerRadius;
            _left = _left + _outlineRadius - _controllerRadius;
          } else {
            _top = details.localPosition.dy - _controllerRadius;

            _left = details.localPosition.dx - _controllerRadius;
          }

          if (!widget.verticalController) {
            _top = _zeroY;
          }
          if (!widget.horizontalController) {
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

          print(
              'setState#2 localPosition=${details.localPosition}  dx=$_dx, dy=$_dy, _left=$_left, _top=$_top, _positionRadius=$_positionRadius, _outlineRadius=$_outlineRadius');

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
          color: Colors.brown,
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
              child: Container(
                color: Colors.blue,
                child: Icon(
                  Icons.circle,
                  size: constraints.maxWidth / 4,
                  color: widget.lineColor,
                  // color: Colors.purple,
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
