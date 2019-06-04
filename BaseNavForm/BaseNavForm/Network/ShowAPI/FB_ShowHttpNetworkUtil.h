//
//  FB_ShowHttpsNetworkUtil.h
//  NewsIntegrated01
//
//  Created by zcx on 2018/7/12.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FB_ShowAPIType)
{
    FB_ShowAPITypeNews = 0,
    FB_ShowAPITypePicture
};

@interface FB_ShowHttpNetworkUtil : NSObject

+(NSURLSessionDataTask *)FB_doHTTPRequestWithUrl:(NSString *)url
                                       parameter:(NSDictionary *)parameter APIType:(FB_ShowAPIType)type
                                        complete:(void (^)(id response, NSError *error))complete;

+ (NSURLSessionDataTask *)FB_doHTTPPostRequestWithUrl:(NSString *)url
                                            parameter:(NSDictionary *)parameter  APIType:(FB_ShowAPIType)type
                                             complete:(void (^)(id response, NSError *error))complete;

+ (NSDictionary *)stringToDictionaryWithJsonString:(NSString *)jsonString;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
