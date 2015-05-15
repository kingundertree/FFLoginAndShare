//
//  FFLoginAndShareManager.m
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/13.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import "FFLoginAndShareManager.h"
#import "FFWeiboShareModel.h"
#import "FFWechatShareModel.h"

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
    
    // 微信初始化
    [WXApi registerApp:@"wxd930ea5d5a258f4f" withDescription:@"demo 2.0"];
}

- (BOOL)handleThirdUrl:(NSURL *)url {
    if (self.thirdApp == ThirdAppTypeForWeibo) {
        [WeiboSDK handleOpenURL:url delegate:self];
    } else if (self.thirdApp == ThirdAppTypeForWeichat) {
        [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

#pragma mark - method
- (void)thirdAppLogin:(ThirdAppType)appType loginInfo:(id)loginInfo loginResponseBlock:(void(^)(ThirdAppType appType, ThirdAppLoginResponseStatus status, id loginCallBackInfo))loginResponseBlock {
    self.loginResponseBlock = loginResponseBlock;
    self.thirdApp = appType;
    
    switch (appType) {
        case ThirdAppTypeForWeibo:
            [self loginWeibo:loginInfo];
            break;
        case ThirdAppTypeForMobileQQ:
            break;
        case ThirdAppTypeForWeichat:
            [self loginWeichat:loginInfo];
            break;
            
        default:
            break;
    }
}

// 第三方分享
- (void)thirdAppShare:(ThirdAppType)appType shareContentType:(ShareContentType)shareContentType shareInfo:(id)shareInfo shareResponseBlock:(void(^)(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo))shareResponseBlock {
    self.shareResponseBlock = shareResponseBlock;
    self.thirdApp = appType;
    
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
        case WechatShareContTypeForFriendWithText:
            [self shareWechatToFriendWithText:shareInfo];
            
            break;
        case WechatShareContTypeForFriendWithImage:
            [self shareWechatToFriendWithImage:shareInfo];

            break;
        case WechatShareContTypeForFriendWithLink:
            [self shareWechatToFriendWithLink:shareInfo];

            break;
        case WechatShareContTypeForFriendGroupWithText:
            [self shareWechatToFriendGroupWithText:shareInfo];
            
            break;
        case WechatShareContTypeForFriendGroupWithImage:
            [self shareWechatToFriendGroupWithImage:shareInfo];

            break;
        case WechatShareContTypeForFriendGroupWithLink:
            [self shareWechatToFriendGroupWithLink:shareInfo];

            break;
            
        default:
            break;
    }
    
}
// 第三方支付
- (void)thirdAppPay:(ThirdAppType)appType payInfo:(id)payInfo payResponseBlock:(void(^)(ThirdAppType appType, ThirdAppPayResponseStatus status, id payCallBackInfo))payResponseBlock {
    if (appType == ThirdAppTypeForWeichat) {
        [self payWithWechat:payInfo];
    } else if (appType == ThirdAppTypeForAlypay) {
        [self payWithAlipay:payInfo];
    }
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
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
    req.state = @"xxx";
    req.openID = @"0c806938e2413ce73eef92cc3";
    
    [WXApi sendAuthReq:req viewController:(UIViewController *)loginInfo delegate:self];
}

#pragma mark - weibo QQ
- (void)loginMobileQQ:(id)loginInfo {
    
}



#pragma mark - weibo text 分享
- (void)shareWeiboWithText:(id)shareInfo {
    FFWeiboShareModel *shareModel = (FFWeiboShareModel *)shareInfo;
    
    NSDictionary *userInfo = shareModel.userInfo;
    
    WBMessageObject *message = [[WBMessageObject alloc] init];
    message.text = shareModel.shareText;

    [self weiboShareHandle:message userInfo:userInfo];
}

#pragma mark - weibo 图片 分享
- (void)shareWeiboWithImage:(id)shareInfo {
    FFWeiboShareModel *shareModel = (FFWeiboShareModel *)shareInfo;
    
    NSDictionary *userInfo = shareModel.userInfo;
    
    WBMessageObject *message = [[WBMessageObject alloc] init];
    message.text = shareModel.shareText;
    WBImageObject *image = [WBImageObject object];
    image.imageData = shareModel.shareImageData;
    message.imageObject = image;
    
    [self weiboShareHandle:message userInfo:userInfo];
}

#pragma mark - weibo 链接 分享
- (void)shareWeiboWithLink:(id)shareInfo {
    FFWeiboShareModel *shareModel = (FFWeiboShareModel *)shareInfo;
    
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

#pragma mark - 微信好友文本分享
- (void)shareWechatToFriendWithText:(id)shareInfo {
    FFWechatShareModel *shareModel = (FFWechatShareModel *)shareInfo;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = shareModel.shareText;
    req.bText = YES;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

#pragma mark - 微信好友图片分享
- (void)shareWechatToFriendWithImage:(id)shareInfo {
    FFWechatShareModel *shareModel = (FFWechatShareModel *)shareInfo;

    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageWithContentsOfFile:shareModel.thumbImageFile]];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = shareModel.bigImageData;
    message.mediaObject = ext;
    
    message.mediaTagName = shareModel.mediaTagName;
    message.messageExt = shareModel.messageExt;
    message.messageAction = shareModel.messageAction;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

#pragma mark - 微信好友链接分享
- (void)shareWechatToFriendWithLink:(id)shareInfo {
    FFWechatShareModel *shareModel = (FFWechatShareModel *)shareInfo;

    WXMediaMessage *message = [WXMediaMessage message];
    message.title = shareModel.title;
    message.description = shareModel.descriptionString;
    [message setThumbImage:[UIImage imageWithContentsOfFile:shareModel.thumbImageFile]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = shareModel.webpageUrl;
    
    message.mediaObject = ext;
    message.mediaTagName = shareModel.mediaTagName;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

#pragma mark - 微信朋友圈文本分享
- (void)shareWechatToFriendGroupWithText:(id)shareInfo {
    FFWechatShareModel *shareModel = (FFWechatShareModel *)shareInfo;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = shareModel.shareText;
    req.bText = YES;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}
#pragma mark - 微信朋友圈图片分享
- (void)shareWechatToFriendGroupWithImage:(id)shareInfo {
    FFWechatShareModel *shareModel = (FFWechatShareModel *)shareInfo;
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageWithContentsOfFile:shareModel.thumbImageFile]];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = shareModel.bigImageData;
    message.mediaObject = ext;
    
    message.mediaTagName = shareModel.mediaTagName;
    message.messageExt = shareModel.messageExt;
    message.messageAction = shareModel.messageAction;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}
#pragma mark - 微信朋友圈链接分享
- (void)shareWechatToFriendGroupWithLink:(id)shareInfo {
    FFWechatShareModel *shareModel = (FFWechatShareModel *)shareInfo;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = shareModel.title;
    message.description = shareModel.descriptionString;
    [message setThumbImage:[UIImage imageWithContentsOfFile:shareModel.thumbImageFile]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = shareModel.webpageUrl;
    
    message.mediaObject = ext;
    message.mediaTagName = shareModel.mediaTagName;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

#pragma mark - 微信支付
- (void)payWithAlipay:(id)payInfo {
//    FFAlipayPayModel *payModel = (FFAlipayPayModel *)payInfo;
    
    __weak typeof(self) this = self;
    [[AlipaySDK defaultService] payOrder:@"" fromScheme:AlipayAppScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"resultDic--->>%@",resultDic);
        ThirdAppPayResponseStatus payResponseStatus = ThirdAppPayResponseStatusForFail;
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) { //订单支付成功
            payResponseStatus = ThirdAppPayResponseStatusForSuccuss;
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) { //正在处理中
            payResponseStatus = ThirdAppPayResponseStatusForProcessing;
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) { //订单支付失败
            payResponseStatus = ThirdAppPayResponseStatusForFail;
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) { //用户中途取消
            payResponseStatus = ThirdAppPayResponseStatusForUserCancle;
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) { //网络连接出错
            payResponseStatus = ThirdAppPayResponseStatusForNetFail;
        }
       
        if (this.payResponseBlock) {
            this.payResponseBlock(ThirdAppTypeForAlypay, payResponseStatus, resultDic);
        }
    }];
}

#pragma mark - 支付宝支付
- (void)payWithWechat:(id)payInfo {
    NSDictionary *dic = (NSDictionary *)payInfo;

    PayReq *request = [[PayReq alloc] init];
    request.partnerId =  dic[@"partnerid"];
    request.prepayId  =  dic[@"prepayid"];
    request.package = dic[@"package"];
    request.nonceStr= dic[@"noncestr"];
    request.timeStamp = [dic[@"timestamp"] doubleValue];
    request.sign= dic[@"sign"];
    [WXApi sendReq:request];
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
        ThirdAppShareResponseStatus status = ThirdAppShareResponseStatusForOhers;
        if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            status = ThirdAppShareResponseStatusForSuccuss;
        } else if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
            status = ThirdAppShareResponseStatusForUserCancle;
        } else {
            status = ThirdAppShareResponseStatusForFail;
        }
        if (self.shareResponseBlock) {
            self.shareResponseBlock(ThirdAppTypeForWeibo, status,sendMessageToWeiboResponse);
        }
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        // 登录验证
        WBSendMessageToWeiboResponse *sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        ThirdAppLoginResponseStatus status = ThirdAppLoginResponseStatusForOhers;
        if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            status = ThirdAppLoginResponseStatusForOhers;
            self.LoginWeiboResponse = sendMessageToWeiboResponse;
        } else if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
            status = ThirdAppLoginResponseStatusForOhers;
        } else {
            status = ThirdAppLoginResponseStatusForOhers;

        }
        if (self.loginResponseBlock) {
            self.loginResponseBlock(ThirdAppTypeForWeibo, status,sendMessageToWeiboResponse);
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

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    [self handWeiboRequest:request];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    [self handWeiboResponse:response];
}

#pragma mark - WXApiDelegate
-(void) onReq:(BaseReq*)req {
    if([req isKindOfClass:[GetMessageFromWXReq class]]) {
        
    } else if([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        
    } else if([req isKindOfClass:[LaunchFromWXReq class]]) {
    
    }
}

-(void) onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *temp = (SendMessageToWXResp*)resp;
        ThirdAppShareResponseStatus sendStatus = ThirdAppShareResponseStatusForOhers;
        
        if (temp.errCode == WXSuccess) {
            sendStatus = ThirdAppShareResponseStatusForSuccuss;
        } else if (temp.errCode == WXErrCodeUserCancel) {
            sendStatus = ThirdAppShareResponseStatusForUserCancle;
        } else {
            sendStatus = ThirdAppShareResponseStatusForFail;
        }
        if (self.shareResponseBlock) {
            self.shareResponseBlock(ThirdAppTypeForWeichat, sendStatus, temp);
        }
    } else if([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        
        ThirdAppLoginResponseStatus sendStatus = ThirdAppLoginResponseStatusForOhers;
        if (temp.errCode == WXSuccess) {
            sendStatus = ThirdAppLoginResponseStatusForSuccuss;
        } else if (temp.errCode == WXErrCodeUserCancel) {
            sendStatus = ThirdAppLoginResponseStatusForUserCancle;
        } else {
            sendStatus = ThirdAppLoginResponseStatusForFail;
        }
        if (self.loginResponseBlock) {
            self.loginResponseBlock(ThirdAppTypeForWeichat, sendStatus, temp);
        }
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
    
    } else if ([resp isKindOfClass:[PayReq class]]) {
        PayResp *temp = (PayResp *)resp;
        
        ThirdAppPayResponseStatus payResponse = ThirdAppPayResponseStatusForOhers;
        if (temp.errCode == WXSuccess) {
            payResponse = ThirdAppPayResponseStatusForSuccuss;
        } else if (temp.errCode == WXErrCodeUserCancel) {
            payResponse = ThirdAppPayResponseStatusForUserCancle;
        } else if (temp.errCode == WXErrCodeSentFail) {
            payResponse = ThirdAppPayResponseStatusForFail;
        } else {
            payResponse = ThirdAppPayResponseStatusForOhers;
        }
        
        if (self.payResponseBlock) {
            self.payResponseBlock(ThirdAppTypeForWeichat,payResponse,temp);
        }
    }
}

@end
