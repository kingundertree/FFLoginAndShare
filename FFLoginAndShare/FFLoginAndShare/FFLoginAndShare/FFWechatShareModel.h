//
//  FFWechatShareModel.h
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/14.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFWechatShareModel : NSObject
@property(nonatomic, strong) NSString *shareText;

@property(nonatomic, strong) NSString *thumbImageFile;
@property(nonatomic, strong) NSData *bigImageData;
@property(nonatomic, strong) NSString *mediaTagName;
@property(nonatomic, strong) NSString *messageExt;
@property(nonatomic, strong) NSString *messageAction;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *descriptionString;
@property(nonatomic, strong) NSString *webpageUrl;

@property(nonatomic, strong) NSDictionary *userInfo;
@end
