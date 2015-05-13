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


typedef NS_ENUM(NSInteger, WeiboShareContType) {
    WeiboShareContTypeForText = 0, //微博分享文本
    WeiboShareContTypeForImage = 1, //微博分享图片
    WeiboShareContTypeForLink = 2 //微博分享连接
};



@interface FFLoginAndShareManager : NSObject <WBHttpRequestDelegate>

+ (instancetype)shareInstance;

// 第三方登录
- (void)thirdAppLogin:(ThirdAppType)appType loginInfo:(id)loginInfo;

// 第三方分享
- (void)thirdAppLogin:(ThirdAppType)appType shareInfo:(id)shareInfo;

// 第三方支付
- (void)thirdAppLogin:(ThirdAppType)appType payInfo:(id)payInfo;

@end
