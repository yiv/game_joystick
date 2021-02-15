#import "GameJoystickPlugin.h"
#if __has_include(<game_joystick/game_joystick-Swift.h>)
#import <game_joystick/game_joystick-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "game_joystick-Swift.h"
#endif

@implementation GameJoystickPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGameJoystickPlugin registerWithRegistrar:registrar];
}
@end
