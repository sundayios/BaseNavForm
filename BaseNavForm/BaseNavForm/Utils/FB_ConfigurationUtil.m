//
//  FB_ConfigurationUtil.m
//  WangCai
//
//  Created by zcx on 2018/7/2.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import "FB_ConfigurationUtil.h"
#import "FB_HttpNetworkUtil+configuration.h"
#import "FB_NetworkUtil.h"

@implementation FB_ConfigurationUtil

static FB_ConfigurationUtil *configuration = nil;
+(FB_ConfigurationUtil *)shareSingleTon{
    NSLock *FB_lock = [[NSLock alloc]init];
    [FB_lock lock];
    if (!configuration) {
        configuration = [[FB_ConfigurationUtil alloc]init];
    }
    [FB_lock unlock];
    return configuration;
}

+ (NSURLSessionTask *)fetchConfigurationSuccess:(void(^)(FB_Configuration *configuration, BOOL isCache))success failure:(void(^)(NSError *error))failure {
    NSDictionary *FB_parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"id",nil];
    __block NSURLSessionTask *FB_task = [FB_NetworkUtil FB_doGetWithURL:kGetConfigguration parameters:FB_parameters needDecode:YES cache:nil success:^(NSDictionary *responseDic) {
        
        FB_Configuration *FB_model = [FB_Configuration modelWithJSON:responseDic[@"code"]];
        if (FB_model && success) {
            success(FB_model, NO);
        } else {
            NSError *FB_err = [NSError errorWithDomain:FB_task.currentRequest.URL.absoluteString code:-1 userInfo:nil];
            failure(FB_err);
        }
    } failure:^(NSError *error) {
        failure ? failure(error) : nil;
    }];

    return FB_task;
}



+ (NSURLSessionTask *)uploadDeviceToken:(NSString *)token {
    NSDictionary *params = @{@"id": @"1111",
                             @"token": token,
                             @"type": @"1",
                             @"model": [[UIDevice currentDevice] getCurrentDeviceModel],
                             @"system": [[UIDevice currentDevice] systemVersion],
                             };
    
    return [FB_NetworkUtil FB_doGetWithURL:kUploadToken parameters:params success:^(NSDictionary *responseDic) {
        NSLog(@"🚀上传token成功 ========== %@", token);
    } failure:^(NSError *error) {
        
    }];
    
}
@end

@implementation FB_Configuration

@end



