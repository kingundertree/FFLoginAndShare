//
//  FFShareModel.h
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/14.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFShareModel : NSObject

@property(nonatomic, strong) NSString *shareText;
@property(nonatomic, strong) NSData *shareImageData;

@property(nonatomic, strong) NSString *objectID;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *descriptionString;
@property(nonatomic, strong) NSData *thumbnailData;
@property(nonatomic, strong) NSString *webpageUrl;


@property(nonatomic, strong) NSDictionary *userInfo;
@end
