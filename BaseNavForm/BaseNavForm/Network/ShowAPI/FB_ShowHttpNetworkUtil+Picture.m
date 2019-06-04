//
//  FB_ShowHttpNetworkUtil+Picture.m
//  NewsIntegrated01
//
//  Created by zcx on 2018/7/18.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_ShowHttpNetworkUtil+Picture.h"

NSString *const getPictureCategory = @"852-1";
NSString *const getPicture = @"852-2";

@implementation FB_ShowHttpNetworkUtil (Picture)

+(NSURLSessionDataTask *)FB_getPictureCategoryWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed
{
    NSURLSessionDataTask *FB_task = [FB_ShowHttpNetworkUtil FB_doHTTPPostRequestWithUrl:getPictureCategory parameter:parameters APIType:FB_ShowAPITypePicture complete:^(id response, NSError *error) {
        if (completed) {
            completed(response,error);
        }
    }];
    return FB_task;
}

+(NSURLSessionDataTask *)FB_getPictureWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed{
    NSURLSessionDataTask *FB_task = [FB_ShowHttpNetworkUtil FB_doHTTPPostRequestWithUrl:getPicture parameter:parameters APIType:FB_ShowAPITypePicture complete:^(id response, NSError *error) {
        if (completed) {
            completed(response,error);
        }
    }];
    return FB_task;
}

@end
