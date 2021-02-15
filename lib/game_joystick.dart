
import 'dart:async';

import 'package:flutter/services.dart';

class GameJoystick {
  static const MethodChannel _channel =
      const MethodChannel('game_joystick');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
