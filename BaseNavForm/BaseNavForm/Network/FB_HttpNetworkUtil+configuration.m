//
//  FB_HttpNetworkUtil+configuration.m
//  WangCai
//
//  Created by zcx on 2018/7/4.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import "FB_HttpNetworkUtil+configuration.h"
#import "AESCipher.h"

static NSString *const getConfigguration = @"app/getappbyid?";
static NSString *const getToken = @"user/saveusertoken";

@implementation FB_HttpNetworkUtil (configuration)


+ (NSURLSessionDataTask *)FB_getAppConfigurationWithParameters:(NSDictionary *)parameters withCompleteBlock:(void(^)(id response,NSError *error))completed
{
   NSURLSessionDataTask *FB_task = [self FB_doHTTPRequestWithType:AFRequestTypePost Url:getConfigguration Parameter:parameters Complete:^(id response, NSError *error) {
       
       if (response) {
           NSString *FB_responseString = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
           NSString *FB_decryptedText = aesDecryptString(FB_responseString, kDecryptKey);
           NSDictionary *FB_responseDict = [[self class] stringToDictionaryWithJsonString:FB_decryptedText];
           if (completed) {
               completed(FB_responseDict,error);
           }
       }else{
           if (completed) {
               completed(response,error);
           }
       }

    }];
    return FB_task;
}

+ (NSURLSessionDataTask *)FB_uploadToken:(NSString *)token withCompleteBlock:(void(^)(id response,NSError *error))completed
{
    
    NSDictionary *FB_params = @{@"id": @"1111",
                             @"token": token,
                             @"type": @"1",
                             @"model": [[UIDevice currentDevice] getCurrentDeviceModel],
                             @"system": [[UIDevice currentDevice] systemVersion],
                             };
    NSURLSessionDataTask *FB_task = [self FB_doHTTPRequestWithType:AFRequestTypePost Url:getToken Parameter:FB_params Complete:^(id response, NSError *error) {
        
        if (response) {
            NSString *FB_responseString = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
            NSDictionary *FB_responseDict = [[self class] stringToDictionaryWithJsonString:FB_responseString];
            if (completed) {
                completed(FB_responseDict,error);
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
