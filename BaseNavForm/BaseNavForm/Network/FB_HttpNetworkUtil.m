//
//  FB_HttpNetworkUtil.m
//  WangCai
//
//  Created by zcx on 2018/7/2.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import "FB_HttpNetworkUtil.h"
#import "FB_PreferenceUtil.h"

static const NSTimeInterval kNetworkTimeoutDuration = 15;
@implementation FB_HttpNetworkUtil

+(NSURLSessionDataTask *)FB_doHTTPRequestWithType:(AFRequestType )type Url:(NSString *)url Parameter:(NSDictionary *)parameter Complete:(void (^)(id response, NSError *error))complete
{
    
    __block NSURLSessionDataTask * FB_task;
    
        if (type == AFRequestTypeGet) {
            FB_task = [self FB_doHTTPRequestWithUrl:url parameter:parameter complete:^(NSData  * response, NSError *error){
                if (complete) {
                    complete(response,error);
                }
            }];
            NSLog(@"\n🚀GET请求完整链接========================================\n\n%@\n\n=================================================🚀🚀🚀", FB_task.currentRequest.URL.absoluteString);
        }else{
            FB_task = [self FB_doHTTPPostRequestWithUrl:url parameter:parameter complete:^(NSData  * response,NSError *error){
                if (complete) {
                    complete(response,error);
                }
            }];
        }
    
    
    return FB_task;
}

+ (NSURLSessionDataTask *)FB_doHTTPRequestWithUrl:(NSString *)url
                                     parameter:(NSDictionary *)parameter
                                      complete:(void (^)(id response, NSError *error))complete
{
    AFHTTPSessionManager *FB_manager = [AFHTTPSessionManager manager];
    FB_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    FB_manager.requestSerializer.timeoutInterval = kNetworkTimeoutDuration;
    
//    [self setHeaderField:manager withParameters:parameter];
    
    //对响应的json数据进行兼容
    AFHTTPResponseSerializer *FB_responseSerializer = [AFHTTPResponseSerializer serializer];
    FB_responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", @"application/x-www-form-urlencoded", @"text/javascript", nil];
    FB_manager.responseSerializer = FB_responseSerializer;
    
    
    NSString *FB_fullURL = [NSString stringWithFormat:@"%@/%@",@"1111",url];
    FB_fullURL = [FB_fullURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"GET请求地址: %@", FB_fullURL);
    NSLog(@"GET参数列表: %@", parameter);
    
    NSURLSessionDataTask *FB_sessionDataTask = [FB_manager GET:FB_fullURL parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"url = %@\n parmas = %@\n responseObject = %@", url, parameter, responseObject);
        if (complete) {
            complete(responseObject, nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
            complete(nil, error);
        }
    }];
    return FB_sessionDataTask;
    
}




+ (NSURLSessionDataTask *)FB_doHTTPPostRequestWithUrl:(NSString *)url
                                         parameter:(NSDictionary *)parameter
                                          complete:(void (^)(id response, NSError *error))complete
{
    AFHTTPSessionManager *FB_manager = [AFHTTPSessionManager manager];
    FB_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    FB_manager.requestSerializer.timeoutInterval = kNetworkTimeoutDuration;
    
    //  对响应的json数据进行兼容
    AFJSONResponseSerializer *FB_responseSerializer = [AFJSONResponseSerializer serializer];
//    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", @"text/javascript", nil];
    FB_responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/json",@"text/plain", nil];
    
    
    FB_manager.responseSerializer = FB_responseSerializer;
    
    NSString *FB_fullURL = [NSString stringWithFormat:@"%@/%@",@"1111",url];
    FB_fullURL = [FB_fullURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"POST请求地址: %@", FB_fullURL);
    NSLog(@"POST参数列表: %@", parameter);
    
    NSURLSessionDataTask *sessionDataTask = [FB_manager POST:FB_fullURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"url = %@\n parmas = %@\n responseObject = %@", url, parameter, responseObject);
        if (complete) {
            complete(responseObject, nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil, error);
    }];
    
    
    return sessionDataTask;
}


//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (!dic) {
        return nil;
    }
    NSError *FB_parseError = nil;
    NSData *FB_jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&FB_parseError];
    
    return [[NSString alloc] initWithData:FB_jsonData encoding:NSUTF8StringEncoding];
}

//json格式字符串转字典：
+ (NSDictionary *)stringToDictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *FB_jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *FB_err;
    
    NSDictionary *FB_dic = [NSJSONSerialization JSONObjectWithData:FB_jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&FB_err];
    
    if(FB_err) {
        
        NSLog(@"json解析失败：%@",FB_err);
        
        return nil;
        
    }
    
    return FB_dic;
    
}


@end
