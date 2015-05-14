//
//  FFLoginAndShareManager.m
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/13.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import "FFLoginAndShareManager.h"
#import "FFShareModel.h"

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
- (void)thirdAppLogin:(ThirdAppType)appType loginInfo:(id)loginInfo loginResponseBlock:(void(^)(ThirdAppType appType, ThirdAppLoginResponseStatus status, id loginCallBackInfo))loginResponseBlock {
    self.loginResponseBlock = loginResponseBlock;
    
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

// 第三方分享
- (void)thirdAppShare:(ThirdAppType)appType shareContentType:(ShareContentType)shareContentType shareInfo:(id)shareInfo shareResponseBlock:(void(^)(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo))shareResponseBlock {
    self.shareResponseBlock = shareResponseBlock;
    
    switch (shareContentType) {
        case WeiboShareContTypeForText:
            [self shareWeiboWithText:shareInfo];
            
            break;
        case WeiboShareContTypeForLink:
            [self shareWeiboWithLink:shareInfo];

            break;
        case WeiboShareContTypeForImage:
            [self shareWeiboWithImage:shareInfo];

            break;
        case WechatShareContTypeForFriend:
            [self shareWechatToFriend:shareInfo];

            break;
        case WechatShareContTypeForFriendGroup:
            [self shareWeiboToFriendGroup:shareInfo];

            break;
            
        default:
            break;
    }
    
}
// 第三方支付
- (void)thirdAppPay:(ThirdAppType)appType payInfo:(id)payInfo payResponseBlock:(void(^)(ThirdAppType appType, ThirdAppPayResponseStatus status, id payCallBackInfo))payResponseBlock {
    
}


#pragma mark - weibo Login
- (void)loginWeibo:(id)loginInfo {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WeiboRedirectURI;
    request.scope = @"all";
    request.userInfo = (NSDictionary *)loginInfo;
    [WeiboSDK sendRequest:request];
}


#pragma mark - weibo wechat
- (void)loginWeichat:(id)loginInfo {
    
}

#pragma mark - weibo QQ
- (void)loginMobileQQ:(id)loginInfo {
    
}

#pragma mark - weibo text 分享
- (void)shareWeiboWithText:(id)shareInfo {
    FFShareModel *shareModel = (FFShareModel *)shareInfo;
    
    NSDictionary *userInfo = shareModel.userInfo;
    
    WBMessageObject *message = [[WBMessageObject alloc] init];
    message.text = shareModel.shareText;
    
    [self weiboShareHandle:message userInfo:userInfo];
}

#pragma mark - weibo 链接 分享
- (void)shareWeiboWithLink:(id)shareInfo {
    FFShareModel *shareModel = (FFShareModel *)shareInfo;
    
    NSDictionary *userInfo = shareModel.userInfo;
    
    WBMessageObject *message = [[WBMessageObject alloc] init];
    message.text = shareModel.shareText;
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = shareModel.objectID;
    webpage.title = shareModel.title;
    webpage.description = shareModel.descriptionString;
    webpage.thumbnailData = shareModel.thumbnailData;
    webpage.webpageUrl = shareModel.webpageUrl;
    message.mediaObject = webpage;
    
    [self weiboShareHandle:message userInfo:userInfo];
}

#pragma mark - weibo 图片 分享
- (void)shareWeiboWithImage:(id)shareInfo {
    FFShareModel *shareModel = (FFShareModel *)shareInfo;
    
    NSDictionary *userInfo = shareModel.userInfo;
    
    WBMessageObject *message = [[WBMessageObject alloc] init];
    message.text = shareModel.shareText;
    WBImageObject *image = [WBImageObject object];
    image.imageData = shareModel.shareImageData;
    message.imageObject = image;
    
    [self weiboShareHandle:message userInfo:userInfo];
}

#pragma mark - 微信好友分享
- (void)shareWechatToFriend:(id)shareInfo {
    
}

#pragma mark - weibo 图片 分享
- (void)shareWeiboToFriendGroup:(id)shareInfo {
    
}


#pragma mark - weibo share method 
- (void)weiboShareHandle:(WBMessageObject *)messageObject userInfo:(NSDictionary *)userInfo{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = WeiboRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject authInfo:authRequest access_token:[(WBAuthorizeResponse *)self.LoginWeiboResponse accessToken]];
    request.userInfo = userInfo;
    [WeiboSDK sendRequest:request];
}

#pragma mark - callBack response 
- (void)callBackThirdAppLoginResponse:(ThirdAppType)appType status:(ThirdAppLoginResponseStatus)status loginInfo:(id)loginInfo {
    if (self.loginResponseBlock) {
        self.loginResponseBlock(appType, status, loginInfo);
    }
}

#pragma mark - hand request
- (void)handWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            if (self.shareResponseBlock) {
                self.shareResponseBlock(ThirdAppTypeForWeibo, ThirdAppShareResponseStatusForSuccuss,sendMessageToWeiboResponse);
            }
        } else if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
            if (self.shareResponseBlock) {
                self.shareResponseBlock(ThirdAppTypeForWeibo, ThirdAppShareResponseStatusForUserCancle,sendMessageToWeiboResponse);
            }
        } else {
            if (self.shareResponseBlock) {
                self.shareResponseBlock(ThirdAppTypeForWeibo, ThirdAppShareResponseStatusForFail,sendMessageToWeiboResponse);
            }
        }
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        // 登录验证
        WBSendMessageToWeiboResponse *sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        
        if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            self.LoginWeiboResponse = sendMessageToWeiboResponse;
            if (self.loginResponseBlock) {
                self.loginResponseBlock(ThirdAppTypeForWeibo, ThirdAppLoginResponseStatusForSuccuss,sendMessageToWeiboResponse);
            }
        } else if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
            if (self.loginResponseBlock) {
                self.loginResponseBlock(ThirdAppTypeForWeibo, ThirdAppLoginResponseStatusForUserCancle,sendMessageToWeiboResponse);
            }
        } else {
            if (self.loginResponseBlock) {
                self.loginResponseBlock(ThirdAppTypeForWeibo, ThirdAppLoginResponseStatusForFail,sendMessageToWeiboResponse);
            }
        }
    } else if ([response isKindOfClass:WBPaymentResponse.class]) {
//        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
    }
}

- (void)handWeiboRequest:(WBBaseRequest *)request {

}

#pragma mark - WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@"收到网络回调------>>%@",result);
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSLog(@"请求异常%@",error);
}


@end
