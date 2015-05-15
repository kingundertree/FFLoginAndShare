//
//  FFLoginAndShareManager.h
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/13.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBHttpRequest.h"
#import "FFLoginAndShareConfig.h"


@interface FFLoginAndShareManager : NSObject <WeiboSDKDelegate,WBHttpRequestDelegate,WXApiDelegate>
@property (nonatomic, strong) WBSendMessageToWeiboResponse *LoginWeiboResponse;
@property (nonatomic, assign) ThirdAppType thirdApp;

@property (nonatomic, copy) void(^loginResponseBlock)(ThirdAppType appType, ThirdAppLoginResponseStatus status, id loginCallBackInfo);
@property (nonatomic, copy) void(^shareResponseBlock)(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo);
@property (nonatomic, copy) void(^payResponseBlock)(ThirdAppType appType, ThirdAppPayResponseStatus status, id payCallBackInfo);


+ (instancetype)shareInstance;
- (BOOL)handleThirdUrl:(NSURL *)url;

// 第三方登录
- (void)thirdAppLogin:(ThirdAppType)appType loginInfo:(id)loginInfo loginResponseBlock:(void(^)(ThirdAppType appType, ThirdAppLoginResponseStatus status, id loginCallBackInfo))loginResponseBlock;

// 第三方分享
- (void)thirdAppShare:(ThirdAppType)appType shareContentType:(ShareContentType)shareContentType shareInfo:(id)shareInfo shareResponseBlock:(void(^)(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo))shareResponseBlock;

// 第三方支付
- (void)thirdAppPay:(ThirdAppType)appType payInfo:(id)payInfo payResponseBlock:(void(^)(ThirdAppType appType, ThirdAppPayResponseStatus status, id payCallBackInfo))payResponseBlock;

- (void)callBackThirdAppLoginResponse:(ThirdAppType)appType status:(ThirdAppLoginResponseStatus)status loginInfo:(id)loginInfo;

- (void)handWeiboResponse:(WBBaseResponse *)response;
- (void)handWeiboRequest:(WBBaseRequest *)request;

@end
