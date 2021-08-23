#import "FlutterYs7Plugin.h"
#if __has_include(<flutter_ys7/flutter_ys7-Swift.h>)
#import <flutter_ys7/flutter_ys7-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_ys7-Swift.h"
#endif

@implementation FlutterYs7Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterYs7Plugin registerWithRegistrar:registrar];
}
@end
