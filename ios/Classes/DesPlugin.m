#import "DesPlugin.h"
#import "DES3Util.h"
#import "Des3Tools.h"

@implementation DesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"des_plugin"
            binaryMessenger:[registrar messenger]];
  DesPlugin* instance = [[DesPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    // 加密
  if ([@"encrypt" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
      NSDictionary *dic = call.arguments;
//      NSLog(@"arguments = %@", dic);
//      NSLog(@"data = %@", [dic objectForKey:@"data"]);
//      NSLog(@"key = %@", [dic objectForKey:@"key"]);
      
      result([DES3Util encryptUseDES:[dic objectForKey:@"data"] key:[dic objectForKey:@"key"]]);
      
  } else if([@"decrypt" isEqualToString:call.method]){
      // 解密
      NSDictionary *dic = call.arguments;
//      NSLog(@"arguments = %@", dic);
//      NSLog(@"data = %@", [dic objectForKey:@"data"]);
//      NSLog(@"key = %@", [dic objectForKey:@"key"]);
      
      result([DES3Util decryptUseDES:[dic objectForKey:@"data"] key:[dic objectForKey:@"key"]]);
  }else if([@"threeDecrypt" isEqualToString:call.method]){
      /// 3des解密
      NSDictionary *dic = call.arguments;
      result([Des3Tools decryptWithText:[dic objectForKey:@"data"] withIv:[dic objectForKey:@"iv"]]);
  }else {
    result(FlutterMethodNotImplemented);
  }
}

@end
