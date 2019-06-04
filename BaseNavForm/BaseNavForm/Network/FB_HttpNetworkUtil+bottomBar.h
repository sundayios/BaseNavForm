//
//  FB_HttpNetworkUtil+bottomBar.h
//  WangCai
//
//  Created by zcx on 2018/7/5.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import "FB_HttpNetworkUtil.h"

@interface FB_HttpNetworkUtil (bottomBar)

+(NSURLSessionDataTask *)FB_getBottomInfoWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed;
@end
