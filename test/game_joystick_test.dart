import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_joystick/game_joystick.dart';

void main() {
  const MethodChannel channel = MethodChannel('game_joystick');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GameJoystick.platformVersion, '42');
  });
}
