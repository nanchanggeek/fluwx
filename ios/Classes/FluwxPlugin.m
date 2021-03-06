#import <fluwx/FluwxPlugin.h>


#import "FluwxAuthHandler.h"

#import "FluwxPaymentHandler.h"
#import "FluwxMethods.h"
#import "FluwxKeys.h"
#import "FluwxWXApiHandler.h"
#import "FluwxShareHandler.h"
#import "FluwxReqHandler.h"
#import "FluwxLaunchMiniProgramHandler.h"
#import "FluwxSubscribeMsgHandler.h"

@implementation FluwxPlugin

BOOL isWeChatRegistered = NO;
BOOL handleOpenURLByFluwx = YES;

FluwxShareHandler *_fluwxShareHandler;
FluwxReqHandler *_fluwxReqHandler;
FluwxAuthHandler *_fluwxAuthHandler;
FluwxWXApiHandler *_fluwxWXApiHandler;
FluwxPaymentHandler *_fluwxPaymentHandler;
FluwxLaunchMiniProgramHandler *_fluwxLaunchMiniProgramHandler;
FluwxSubscribeMsgHandler *_fluwxSubscribeMsgHandler;

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"com.jarvanmo/fluwx"
                  binaryMessenger:[registrar messenger]];

    FluwxPlugin *instance = [[FluwxPlugin alloc] initWithRegistrar:registrar methodChannel:channel];
    [[FluwxResponseHandler defaultManager] setMethodChannel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];


}

- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar  methodChannel:(FlutterMethodChannel *)flutterMethodChannel {
    self = [super init];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(handleOpenURL:)
//                                                 name:@"WeChat"
//                                               object:nil];
    if (self) {
        _fluwxShareHandler = [[FluwxShareHandler alloc] initWithRegistrar:registrar];
        _fluwxReqHandler = [[FluwxReqHandler alloc] initWithRegistrar:registrar];
        _fluwxAuthHandler = [[FluwxAuthHandler alloc] initWithRegistrar:registrar methodChannel:flutterMethodChannel] ;
        _fluwxWXApiHandler = [[FluwxWXApiHandler alloc] init];
        _fluwxPaymentHandler = [[FluwxPaymentHandler alloc] initWithRegistrar:registrar];
        _fluwxLaunchMiniProgramHandler = [[FluwxLaunchMiniProgramHandler alloc] initWithRegistrar:registrar];
        _fluwxSubscribeMsgHandler = [[FluwxSubscribeMsgHandler alloc] initWithRegistrar:registrar];
    }

    return self;
}




- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {


    if ([registerApp isEqualToString:call.method]) {
        [_fluwxWXApiHandler registerApp:call result:result];
        return;
    }

    if([@"isWeChatInstalled" isEqualToString :call.method]){
        [_fluwxWXApiHandler checkWeChatInstallation:call result:result];
        return;
    }


    if([@"sendAuth" isEqualToString :call.method]){
        [_fluwxAuthHandler handleAuth:call result:result];
        return;
    }

    if([@"payWithFluwx" isEqualToString :call.method]){
        [_fluwxPaymentHandler handlePayment:call result:result];
        return;
    }

    if([@"launchMiniProgram" isEqualToString :call.method]){
        [_fluwxLaunchMiniProgramHandler handleLaunchMiniProgram:call result:result];
        return;
    }
    
    if([@"subscribeMsg" isEqualToString: call.method]){
        [_fluwxSubscribeMsgHandler handleSubscribeWithCall:call result:result];
        return;
    }

    if([@"authByQRCode" isEqualToString:call.method]){
        [_fluwxAuthHandler authByQRCode:call result:result];
        return;
    }

    if([@"stopAuthByQRCode" isEqualToString:call.method]){
        [_fluwxAuthHandler stopAuthByQRCode:call result:result];
        return;
    }

    if ([call.method hasPrefix:@"share"]) {
        [_fluwxShareHandler handleShare:call result:result];
        return;
    } else {
        result(FlutterMethodNotImplemented);
    }

    if ([call.method hasPrefix:@"req_"]) {
        [_fluwxReqHandler handleReq:call result:result];
        return;
    } else {
        result(FlutterMethodNotImplemented);
    }

}


-(BOOL)handleOpenURL:(NSNotification *)aNotification {

    if(handleOpenURLByFluwx){
        NSString * aURLString =  [aNotification userInfo][@"url"];
        NSURL * aURL = [NSURL URLWithString:aURLString];
        return [WXApi handleOpenURL:aURL delegate:[FluwxResponseHandler defaultManager]];
    } else{
        return NO;
    }

}

- (void)unregisterApp:(FlutterMethodCall *)call result:(FlutterResult)result {

    isWeChatRegistered = false;
    result(@YES);
}


@end
