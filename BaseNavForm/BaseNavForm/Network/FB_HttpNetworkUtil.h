//
//  FB_HttpNetworkUtil.h
//  WangCai
//
//  Created by zcx on 2018/7/2.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger,AFRequestType)
{
    AFRequestTypeGet = 0,
    AFRequestTypePost,
};

extern NSString *const kDecryptKey;

@interface FB_HttpNetworkUtil : NSObject

+(NSURLSessionDataTask *)FB_doHTTPRequestWithType:(AFRequestType )type Url:(NSString *)url Parameter:(NSDictionary *)parameter Complete:(void (^)(id response, NSError *error))complete;

+(NSURLSessionDataTask *)FB_doHTTPRequestWithUrl:(NSString *)url
                                    parameter:(NSDictionary *)parameter
                                     complete:(void (^)(id response, NSError *error))complete;

+ (NSURLSessionDataTask *)FB_doHTTPPostRequestWithUrl:(NSString *)url
                                         parameter:(NSDictionary *)parameter
                                          complete:(void (^)(id response, NSError *error))complete;

+ (NSDictionary *)stringToDictionaryWithJsonString:(NSString *)jsonString;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
