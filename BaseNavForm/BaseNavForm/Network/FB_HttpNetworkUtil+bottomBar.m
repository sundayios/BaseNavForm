//
//  FB_HttpNetworkUtil+bottomBar.m
//  WangCai
//
//  Created by zcx on 2018/7/5.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import "FB_HttpNetworkUtil+bottomBar.h"

//static NSString *const getConfigguration = @"baritem/getbaritembyid?";
static NSString *const getConfigguration = @"baritem/getbaritembyappid?";

@implementation FB_HttpNetworkUtil (bottomBar)

+(NSURLSessionDataTask *)FB_getBottomInfoWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed{
    
    NSURLSessionDataTask *FB_task = [self FB_doHTTPRequestWithType:AFRequestTypeGet Url:getConfigguration Parameter:parameters Complete:^(id response, NSError *error) {
        
        if (response) {
//            NSString *responseString = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
//            NSDictionary *responseDict = [[self class] stringToDictionaryWithJsonString:responseString];
            if (completed) {
                completed(response,error);
            }
        }else{
            if (completed) {
                completed(response,error);
            }
        }
        
    }];
    return FB_task;
    
}
@end
