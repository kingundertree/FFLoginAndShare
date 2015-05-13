//
//  FFLoginAndShareManager.m
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/13.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import "FFLoginAndShareManager.h"
#import "WeiboSDK.h"

@implementation FFLoginAndShareManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static FFLoginAndShareManager *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[FFLoginAndShareManager alloc] init];
    });
    return shareInstance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self thidrAppInit];
    }
    
    return self;
}

- (void)thidrAppInit {
    // 微博sdk初始化
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WeiboAppKey];
}

#pragma mark - method
- (void)thirdAppLogin:(ThirdAppType)appType loginInfo:(id)loginInfo {
    switch (appType) {
        case ThirdAppTypeForWeibo:
            [self loginWeibo:loginInfo];
            break;
        case ThirdAppTypeForMobileQQ:
            [self loginWeibo:loginInfo];
            break;
        case ThirdAppTypeForWeichat:
            [self loginWeibo:loginInfo];
            break;
            
        default:
            break;
    }
}

- (void)thirdAppLogin:(ThirdAppType)appType shareInfo:(id)shareInfo {

}

- (void)thirdAppLogin:(ThirdAppType)appType payInfo:(id)payInfo {

}

#pragma mark - weibo Login
- (void)loginWeibo:(id)loginInfo {
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = WeiboRedirectURI;
//    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    [WeiboSDK sendRequest:request];
}

#pragma mark - weibo wechat
- (void)loginWeichat:(id)loginInfo {
    
}

#pragma mark - weibo QQ
- (void)loginMobileQQ:(id)loginInfo {
    
}


@end
