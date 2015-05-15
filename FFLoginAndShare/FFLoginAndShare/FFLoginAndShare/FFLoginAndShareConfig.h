//
//  FFLoginAndShareConfig.h
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/13.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#ifndef FFLoginAndShare_FFLoginAndShareConfig_h
#define FFLoginAndShare_FFLoginAndShareConfig_h

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "FFAlipayPayModel.h"
#import <AlipaySDK/AlipaySDK.h>

#define WeiboAppKey  @"2045436852"
#define WeiboRedirectURI  @"http://www.sina.com"

#define WechatAppKey @"wxd930ea5d5a258f4f"

#define AlipayPartner  @"2088901056726684"
#define AlipaySeller  @"zftest@anjuke.com"
#define AlipayPrivateKey  @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANKM3iXoWqJ4xvT+MbqBaudHXF1FkvHKf8O+75Vj+KqhQ85Hil1+eAR3TK7i6EgCrTv7wOk4KbljAx1kiel4Gf2CqSIekLYecQ3mbiDmNpx5o864RTHeRdziVdXOfarrb+qGblNTqUqkZCVcL3LsqBpT8MwBD5w9ILlz6/voFzXdAgMBAAECgYBioTJ/N3Udns40fc71uyJE7RzLZIgNU/q9y3eX15jo9Vo6CzE50sCN9wSo+AovkXFtI+WeWnzRJxySbEJeZ7BkQywYd67x+9jBNzMUVeINk6PeaNv/mR8Sy/4eH3xvtB3wB7Sr60Fmy/6eYwDjIpRsU0TC0iRyq0MVQ5aZHUzEUQJBAPX+8RtZsuil+Na0fFtop+ZWZV3wqtB0i9WepJjWahaq/atCPSA8Mns9APw9uv4viFpka13rMZQ5uOOuCOyJq+8CQQDbHOcIbFVXICD4NRf5215dDhYoxyG2RY9DvmmiCTC/14k+h/McqsAxHOpj4tuPJVvGgY2TXxTW83j8evMd7R7zAkEAvaPjhd05sma5FfQf5mwg+85g6PGvDXK7llxtsbGiKYV6d3tiGiauGBmoV8zTCj/kkyLVLpsxJn71TPiOwqNDmwJAFP4s6HKwrntGjWFQ3cB1xwadeuSxRyxc8Imix0KIKCk3XgVadomphksV7eIDVTCoHVm2PcNjVMDY+5+wAVMBnwJAN6jOeq8x7Y4XqCZWG7RrGjbfp8C5NLbSu96ZSpBRjOEXpZD+OXtboqsaTHZC42Q8ODI591jhugwvIMm+7e9F/w==";
#define AlipayAppScheme  @"alisdkdemo"


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
    WechatShareContTypeForFriendWithText = 3, //微信好友文本分享
    WechatShareContTypeForFriendWithImage = 4, //微信好友图片分享
    WechatShareContTypeForFriendWithLink = 5, //微信好友链接分享
    WechatShareContTypeForFriendGroupWithText = 6, //微信朋友圈文本分享
    WechatShareContTypeForFriendGroupWithImage = 7, //微信朋友圈文本分享
    WechatShareContTypeForFriendGroupWithLink = 8 //微信朋友圈文本分享
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
    ThirdAppPayResponseStatusForProcessing = 2, //支付中
    ThirdAppPayResponseStatusForFail = 3, //支付失败
    ThirdAppPayResponseStatusForNetFail = 4, //支付网络失败
    ThirdAppPayResponseStatusForOhers = 5 //其他
};


#endif
