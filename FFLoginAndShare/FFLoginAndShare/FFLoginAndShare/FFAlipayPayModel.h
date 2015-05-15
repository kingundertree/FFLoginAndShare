//
//  FFAlipayPayModel.h
//  FFLoginAndShare
//
//  Created by xiazer on 15/5/15.
//  Copyright (c) 2015年 FF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFAlipayPayModel : NSObject

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller;
@property(nonatomic, copy) NSString * tradeNO;
@property(nonatomic, copy) NSString * productName;
@property(nonatomic, copy) NSString * productDescription;
@property(nonatomic, copy) NSString * amount;
@property(nonatomic, copy) NSString * notifyURL;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;
@property(nonatomic, copy) NSString * appID;

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

@end
