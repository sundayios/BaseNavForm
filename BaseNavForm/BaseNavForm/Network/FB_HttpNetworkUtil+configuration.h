//
//  FB_HttpNetworkUtil+configuration.h
//  WangCai
//
//  Created by zcx on 2018/7/4.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import "FB_HttpNetworkUtil.h"

@interface FB_HttpNetworkUtil (configuration)

+(NSURLSessionDataTask *)FB_getAppConfigurationWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed;

+ (NSURLSessionDataTask *)FB_uploadToken:(NSString *)token withCompleteBlock:(void(^)(id response,NSError *error))completed;
@end
