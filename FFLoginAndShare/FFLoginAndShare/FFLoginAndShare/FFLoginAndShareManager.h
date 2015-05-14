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
#import "WeiboSDK.h"

typedef NS_ENUM(NSInteger, ThirdAppActionType) {
    ThirdAppActionTypeForLogin = 0, //第三方app操作登录
    ThirdAppActionTypeForShare = 1, //第三方app操作分享
    ThirdAppActionTypeForPay = 2 //第三方app操作支付
};


typedef NS_ENUM(NSUInteger, ThirdAppType) {
    ThirdAppTypeForWeibo = 0, // 第三方App微博
    ThirdAppTypeForMobileQQ = 1, // 第三方App手机QQ
    ThirdAppTypeForWeichat = 2, // 第三方App微信
    ThirdAppTypeForAlypay = 3 // 第三方App支付宝
};


typedef NS_ENUM(NSInteger, ShareContentType) {
    WeiboShareContTypeForText = 0, //微博分享文本
    WeiboShareContTypeForImage = 1, //微博分享图片
    WeiboShareContTypeForLink = 2, //微博分享连接
    WechatShareContTypeForFriend = 3, //微信好友分享
    WechatShareContTypeForFriendGroup = 4 //微信朋友圈分享

};

typedef NS_ENUM(NSInteger, ThirdAppLoginResponseStatus) {
    ThirdAppLoginResponseStatusForSuccuss = 0, //登录成功
    ThirdAppLoginResponseStatusForUserCancle = 1, //用户取消登录
    ThirdAppLoginResponseStatusForFail = 2, //登录失败
    ThirdAppLoginResponseStatusForOhers = 3 //其他
};

typedef NS_ENUM(NSInteger, ThirdAppShareResponseStatus) {
    ThirdAppShareResponseStatusForSuccuss = 0, //分享成功
    ThirdAppShareResponseStatusForUserCancle = 1, //用户取消分享
    ThirdAppShareResponseStatusForFail = 2, //分享失败
    ThirdAppShareResponseStatusForOhers = 3 //其他
};

typedef NS_ENUM(NSInteger, ThirdAppPayResponseStatus) {
    ThirdAppPayResponseStatusForSuccuss = 0, //支付成功
    ThirdAppPayResponseStatusForUserCancle = 1, //用户取消支付
    ThirdAppPayResponseStatusForFail = 2, //支付失败
    ThirdAppPayResponseStatusForOhers = 3 //其他
};


@interface FFLoginAndShareManager : NSObject <WBHttpRequestDelegate>
@property (nonatomic, strong) WBSendMessageToWeiboResponse *LoginWeiboResponse;

@property (nonatomic, copy) void(^loginResponseBlock)(ThirdAppType appType, ThirdAppLoginResponseStatus status, id loginCallBackInfo);
@property (nonatomic, copy) void(^shareResponseBlock)(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo);
@property (nonatomic, copy) void(^payResponseBlock)(ThirdAppType appType, ThirdAppPayResponseStatus status, id payCallBackInfo);


+ (instancetype)shareInstance;

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
