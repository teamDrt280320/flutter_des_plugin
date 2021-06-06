#import "DesPlugin.h"
#if __has_include(<des_plugin/des_plugin-Swift.h>)
#import <des_plugin/des_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "des_plugin-Swift.h"
#endif

@implementation DesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDesPlugin registerWithRegistrar:registrar];
}
@end
