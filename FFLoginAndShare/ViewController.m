//
//  ViewController.m
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/13.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import "ViewController.h"
#import "FFLoginAndShareManager.h"
#import "FFShareModel.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(0, 50+50*i, self.view.frame.size.width, 40);
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
        FFShareModel *shareModel = [[FFShareModel alloc] init];
        shareModel.shareText = @"我来啦~FF";
        
        [[FFLoginAndShareManager shareInstance] thirdAppShare:ThirdAppTypeForWeibo shareContentType:WeiboShareContTypeForText shareInfo:shareModel shareResponseBlock:^(ThirdAppType appType, ThirdAppShareResponseStatus status, id shareCallBackInfo) {
            if (status == ThirdAppShareResponseStatusForSuccuss) {
                NSLog(@"文本分享成功");
            } else {
                NSLog(@"文本分享失败");
            }
        }];
    } else if (btn.tag == 2) {
        FFShareModel *shareModel = [[FFShareModel alloc] init];
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
        FFShareModel *shareModel = [[FFShareModel alloc] init];
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
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
