//
// Created by mo on 2018/8/16.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <Flutter/Flutter.h>
#import "FluwxPlugin.h"
#import "WXApiRequestHandler.h"
@class StringUtil;

@interface FluwxReqHandler : NSObject
-(instancetype) initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
- (void)handleReq:(FlutterMethodCall *)call result:(FlutterResult)result;
@end
