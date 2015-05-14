//
//  ViewController.m
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/13.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import "ViewController.h"
#import "FFLoginAndShareManager.h"
#import "FFWeiboShareModel.h"
#import "FFWechatShareModel.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    for (NSInteger i = 0; i < 11; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(0, 40+40*i, self.view.frame.size.width, 35);
        btn.backgroundColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:btn];
        
        if (i == 0) {
            [btn setTitle:@"weibo Login" forState:UIControlStateNormal];
        } else if (i == 1) {
            [btn setTitle:@"weibo text Share" forState:UIControlStateNormal];
        } else if (i == 2) {
            [btn setTitle:@"weibo image Share" forState:UIControlStateNormal];
        } else if (i == 3) {
            [btn setTitle:@"weibo link Share" forState:UIControlStateNormal];
        } else if (i == 4) {
            [btn setTitle:@"wechat friend text Share" forState:UIControlStateNormal];
        } else if (i == 5) {
            [btn setTitle:@"wechat friend image Share" forState:UIControlStateNormal];
        } else if (i == 6) {
            [btn setTitle:@"wechat friend link Share" forState:UIControlStateNormal];
        } else if (i == 7) {
            [btn setTitle:@"wechat friendGroup text Share" forState:UIControlStateNormal];
        } else if (i == 8) {
            [btn setTitle:@"wechat friendGroup image Share" forState:UIControlStateNormal];
        } else if (i == 9) {
            [btn setTitle:@"wechat friendGroup link Share" forState:UIControlStateNormal];
        } else if (i == 10) {
            [btn setTitle:@"wechat Login" forState:UIControlStateNormal];
        }
    }
}

- (void)click:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 0) {
        NSDictionary *loginInfo = @{@"SSO_From": @"ViewController",@"Other_Info_1": [NSNumber numberWithInt:123],@"Other_Info_2": @[@"obj1", @"obj2"],@"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        
        [[FFLoginAndShareManager shareInstance] thirdAppLogin:ThirdAppTypeForWeibo loginInfo:loginInfo loginResponseBlock:^(ThirdAppType appType, ThirdAppLoginResponseStatus status, id loginCallBackInfo) {
            if (appType == ThirdAppTypeForWeibo && status == ThirdAppLoginResponseStatusForSuccuss) {
                WBSendMessageToWeiboResponse *loginInfo = (WBSendMessageToWeiboResponse*)loginCallBackInfo;

                NSLog(@"loginInfo--->>%@",loginInfo.userInfo);
            }
        }];
    } else if (btn.tag == 1) {
        FFWeiboShareModel *shareModel = [[FFWeiboShareModel alloc] init];
        shareModel.shareText = @"我来啦~FF";
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeibo shareContentType:WeiboShareContTypeForText shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"文本分享成功");
            } else {
                NSLog(@"文本分享失败");
            }
        }];
    } else if (btn.tag == 2) {
        FFWeiboShareModel *shareModel = [[FFWeiboShareModel alloc] init];
        shareModel.shareText = @"我来啦~FF";
        shareModel.shareImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"]];
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeibo shareContentType:WeiboShareContTypeForImage shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"图片分享成功");
            } else {
                NSLog(@"图片分享失败");
            }
        }];
    } else if (btn.tag == 3) {
        // 暂时有问题
        FFWeiboShareModel *shareModel = [[FFWeiboShareModel alloc] init];
        shareModel.shareText = @"我来啦~FF";
        shareModel.objectID = @"identifier";
        shareModel.title = @"FFShare";
        shareModel.descriptionString = @"trueth";
        shareModel.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"]];
        shareModel.webpageUrl = @"http://kingundertree.github.io";
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeibo shareContentType:WeiboShareContTypeForLink shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"连接分享成功");
            } else {
                NSLog(@"连接分享失败");
            }
        }];
    } else if (btn.tag == 4) {
        FFWechatShareModel *shareModel = [[FFWechatShareModel alloc] init];
        shareModel.shareText = @"我们对食材的质量与安全的管控极不简单，而且苛刻而繁琐。从原产地寻找与合作，评估挑选追溯，实验室检测，多温区储藏到冷藏车配送。我们用欧洲的标准来管理这一切。这是我们每天的工作，不断重复，不断进步。";
    
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeichat shareContentType:WechatShareContTypeForFriendWithText shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"微信好友文本分享成功");
            } else {
                NSLog(@"微信好友文本分享失败");
            }
        }];
    } else if (btn.tag == 5) {
        FFWechatShareModel *shareModel = [[FFWechatShareModel alloc] init];
        shareModel.thumbImageFile = [[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"];
        shareModel.bigImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"]];
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeichat shareContentType:WechatShareContTypeForFriendWithImage shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"微信好友图片分享成功");
            } else {
                NSLog(@"微信好友图片分享失败");
            }
        }];
    } else if (btn.tag == 6) {
        FFWechatShareModel *shareModel = [[FFWechatShareModel alloc] init];
        shareModel.title = @"kingundertree 博客";
        shareModel.descriptionString = @"我们对食材的质量与安全的管控极不简单，而且苛刻而繁琐。从原产地寻找与合作，评估挑选追溯，实验室检测，多温区储藏到冷藏车配送。我们用欧洲的标准来管理这一切。这是我们每天的工作，不断重复，不断进步。";
        shareModel.thumbImageFile = [[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"];
        shareModel.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeichat shareContentType:WechatShareContTypeForFriendWithLink shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"微信好友链接分享成功");
            } else {
                NSLog(@"微信好友链接分享失败");
            }
        }];
    } else if (btn.tag == 7) {
        FFWechatShareModel *shareModel = [[FFWechatShareModel alloc] init];
        shareModel.shareText = @"我们对食材的质量与安全的管控极不简单，而且苛刻而繁琐。从原产地寻找与合作，评估挑选追溯，实验室检测，多温区储藏到冷藏车配送。我们用欧洲的标准来管理这一切。这是我们每天的工作，不断重复，不断进步。";
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeichat shareContentType:WechatShareContTypeForFriendGroupWithText shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"微信朋友圈文本分享成功");
            } else {
                NSLog(@"微信朋友圈文本分享失败");
            }
        }];
    } else if (btn.tag == 8) {
        FFWechatShareModel *shareModel = [[FFWechatShareModel alloc] init];
        shareModel.thumbImageFile = [[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"];
        shareModel.bigImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"]];
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeichat shareContentType:WechatShareContTypeForFriendGroupWithImage shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"微信朋友圈图片分享成功");
            } else {
                NSLog(@"微信朋友圈图片分享失败");
            }
        }];
    } else if (btn.tag == 9) {
        FFWechatShareModel *shareModel = [[FFWechatShareModel alloc] init];
        shareModel.title = @"kingundertree 博客";
        shareModel.descriptionString = @"我们对食材的质量与安全的管控极不简单，而且苛刻而繁琐。从原产地寻找与合作，评估挑选追溯，实验室检测，多温区储藏到冷藏车配送。我们用欧洲的标准来管理这一切。这是我们每天的工作，不断重复，不断进步。";
        shareModel.thumbImageFile = [[NSBundle mainBundle] pathForResource:@"1jpeg" ofType:@"jpg"];
        shareModel.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeichat shareContentType:WechatShareContTypeForFriendGroupWithLink shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"微信朋友圈图片分享成功");
            } else {
                NSLog(@"微信朋友圈图片分享失败");
            }
        }];
    } else if (btn.tag == 10) {        
        [[FFLoginAndShareManager shareInstance] thirdAppLogin:ThirdAppTypeForWeichat loginInfo:self loginResponseBlock:^(ThirdAppType appType, ThirdAppLoginResponseStatus status, id loginCallBackInfo) {
            if (appType == ThirdAppTypeForWeichat && status == ThirdAppLoginResponseStatusForSuccuss) {
                NSLog(@"loginInfo--->>微信登录成功");
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
