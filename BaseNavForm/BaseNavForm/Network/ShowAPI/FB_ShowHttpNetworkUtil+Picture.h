//
//  FB_ShowHttpNetworkUtil+Picture.h
//  NewsIntegrated01
//
//  Created by zcx on 2018/7/18.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_ShowHttpNetworkUtil.h"

@interface FB_ShowHttpNetworkUtil (Picture)

+(NSURLSessionDataTask *)FB_getPictureCategoryWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed;

+(NSURLSessionDataTask *)FB_getPictureWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed;

@end
