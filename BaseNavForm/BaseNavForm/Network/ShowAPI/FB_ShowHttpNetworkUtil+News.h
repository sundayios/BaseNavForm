//
//  FB_ShowHttpNetworkUtil+News.h
//  NewsIntegrated01
//
//  Created by zcx on 2018/7/12.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_ShowHttpNetworkUtil.h"

@interface FB_ShowHttpNetworkUtil (News)

+(NSURLSessionDataTask *)FB_getNewsWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed;

+(NSURLSessionDataTask *)FB_getChannelListWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed;

@end
