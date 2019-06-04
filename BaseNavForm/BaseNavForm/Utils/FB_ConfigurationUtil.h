//
//  FB_ConfigurationUtil.h
//  WangCai
//
//  Created by zcx on 2018/7/2.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FB_Configuration;
@interface FB_ConfigurationUtil : NSObject

+ (FB_ConfigurationUtil *)shareSingleTon;


+ (NSURLSessionTask *)fetchConfigurationSuccess:(void(^)(FB_Configuration *configuration, BOOL isCache))success failure:(void(^)(NSError *error))failure;

+ (NSURLSessionTask *)uploadDeviceToken:(NSString *)token;
@end


@interface FB_Configuration : NSObject

@property (nonatomic, copy)NSString *appId;
@property (nonatomic, copy)NSString *appName;
@property (nonatomic, copy)NSString *verticalOrHorizontal;
@property (nonatomic, copy)NSString *showBottom;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *defaultUrl;
@property (nonatomic, copy)NSString *status;

@end
