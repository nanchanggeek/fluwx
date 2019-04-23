//
// Created by mo on 2018/8/16.
//


#import "FluwxReqHandler.h"
#import "CallResults.h"

#import "FluwxKeys.h"
#import "FluwxMethods.h"
#import "StringUtil.h"
#import "NSStringWrapper.h"

@implementation FluwxReqHandler {
   NSObject <FlutterPluginRegistrar> *_registrar;
}

- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        _registrar = registrar;
    }

    return self;
}


- (void)handleReq:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (!isWeChatRegistered) {
        result([FlutterError errorWithCode:resultErrorNeedWeChat message:resultMessageNeedWeChat details:nil]);
        return;
    }

    if (![WXApi isWXAppInstalled]) {
        result([FlutterError errorWithCode:@"wechat not installed" message:@"wechat not installed" details:nil]);
        return;
    }

    if ([openWebview isEqualToString:call.method]) {
        [self openWebview:call result:result];
    } 
}

- (void)openWebview:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *url = call.arguments[fluwxKeyUrl];
    BOOL done = [WXApiRequestHandler openUrl: url];
    result(@{fluwxKeyPlatform: fluwxKeyIOS, fluwxKeyResult: @(done)});
}

@end
