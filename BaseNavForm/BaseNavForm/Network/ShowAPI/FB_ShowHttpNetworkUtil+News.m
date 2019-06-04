//
//  FB_ShowHttpNetworkUtil+News.m
//  NewsIntegrated01
//
//  Created by zcx on 2018/7/12.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_ShowHttpNetworkUtil+News.h"

static NSString *const getNews = @"109-35";
static NSString *const getChannelList = @"109-34";
@implementation FB_ShowHttpNetworkUtil (News)

+(NSURLSessionDataTask *)FB_getNewsWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed
{
    NSURLSessionDataTask *FB_task = [FB_ShowHttpNetworkUtil FB_doHTTPPostRequestWithUrl:getNews parameter:parameters APIType:FB_ShowAPITypeNews complete:^(id response, NSError *error) {
        if (completed) {
            completed(response,error);
        }
    }];
    return FB_task;
}

+(NSURLSessionDataTask *)FB_getChannelListWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed{
    NSURLSessionDataTask *FB_task = [FB_ShowHttpNetworkUtil FB_doHTTPPostRequestWithUrl:getChannelList parameter:nil APIType:FB_ShowAPITypeNews complete:^(id response, NSError *error) {
        if (completed) {
            completed(response,error);
        }
    }];
    
    return FB_task;
}
@end
