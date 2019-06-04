//
//  FB_ShowHttpsNetworkUtil.m
//  NewsIntegrated01
//
//  Created by zcx on 2018/7/12.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_ShowHttpNetworkUtil.h"


//服务器基地址
NSString * const showNewsHost = @"http://route.showapi.com";
NSString * const showNewsAPPId = @"69373";
NSString * const showNewsSecret = @"4453f4598a8045a69d22bd02a0f454b5";

NSString * const showPictureAPPid = @"70009";
NSString * const showPictureSecret = @"290afac9c0674220a542c4d868f6d291";

static const NSTimeInterval kNetworkTimeoutDuration = 15;

@implementation FB_ShowHttpNetworkUtil
+ (NSURLSessionDataTask *)FB_doHTTPRequestWithUrl:(NSString *)url
                                        parameter:(NSDictionary *)parameter  APIType:(FB_ShowAPIType)type
                                         complete:(void (^)(id response, NSError *error))complete
{
    AFHTTPSessionManager *FB_manager = [AFHTTPSessionManager manager];
    FB_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    FB_manager.requestSerializer.timeoutInterval = kNetworkTimeoutDuration;
    
    //对响应的json数据进行兼容
    AFHTTPResponseSerializer *FB_responseSerializer = [AFHTTPResponseSerializer serializer];
    FB_responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/html", @"application/x-www-form-urlencoded", @"text/javascript", nil];
    FB_manager.responseSerializer = FB_responseSerializer;
        
    NSString *FB_fullURL = [NSString stringWithFormat:@"%@/%@?",showNewsHost,url];
    FB_fullURL = [FB_fullURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSDictionary * FB_fullParameter = [[self class] setPublicParameter:parameter withType:type];
    
    NSLog(@"GET请求地址: %@", FB_fullURL);
    NSLog(@"GET参数列表: %@", FB_fullParameter);
    
    NSURLSessionDataTask *FB_sessionDataTask = [FB_manager GET:FB_fullURL parameters:FB_fullParameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *FB_responseDict = [[self class] DataToDictionary:responseObject];
            if (complete) {
                complete(FB_responseDict, nil);
            }
        }else{
            if (complete) {
                complete(responseObject, nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
            complete(nil, error);
        }
    }];
    return FB_sessionDataTask;
    
}

+ (NSURLSessionDataTask *)FB_doHTTPPostRequestWithUrl:(NSString *)url
                                            parameter:(NSDictionary *)parameter  APIType:(FB_ShowAPIType)type
                                             complete:(void (^)(id response, NSError *error))complete
{
    AFHTTPSessionManager *FB_manager = [AFHTTPSessionManager manager];
    FB_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    FB_manager.requestSerializer.timeoutInterval = kNetworkTimeoutDuration;
    
    //  对响应的json数据进行兼容
    AFHTTPResponseSerializer *FB_responseSerializer = [AFHTTPResponseSerializer serializer];
    FB_responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/html", @"application/x-www-form-urlencoded", @"text/javascript", nil];
    FB_manager.responseSerializer = FB_responseSerializer;
    
    NSString *FB_fullURL = [NSString stringWithFormat:@"%@/%@?",showNewsHost,url];
    FB_fullURL = [FB_fullURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSDictionary * FB_fullParameter = [[self class] setPublicParameter:parameter withType:type];
    NSLog(@"POST请求地址: %@", FB_fullURL);
    NSLog(@"POST参数列表: %@", FB_fullParameter);
    
    NSURLSessionDataTask *FB_sessionDataTask = [FB_manager POST:FB_fullURL parameters:FB_fullParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *FB_responseDict = [[self class] DataToDictionary:responseObject];
            if (complete) {
                complete(FB_responseDict, nil);
            }
        }else{
            if (complete) {
                complete(responseObject, nil);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
             complete(nil, error);
        }
    }];
    
    return FB_sessionDataTask;
}


+(NSDictionary *)setPublicParameter:(NSDictionary *)paramster withType:(FB_ShowAPIType)type
{
    
    switch (type) {
        case FB_ShowAPITypeNews:
        {
            if (!paramster) {
                return @{@"showapi_appid":showNewsAPPId,
                         @"showapi_sign":showNewsSecret
                         };
            }else{
                NSMutableDictionary *FB_dictM = [NSMutableDictionary dictionaryWithDictionary:paramster];
                [FB_dictM setObject:showNewsAPPId forKey:@"showapi_appid"];
                [FB_dictM setObject:showNewsSecret forKey:@"showapi_sign"];
                return FB_dictM;
            }
        }
            break;
        case FB_ShowAPITypePicture:
        {
            if (!paramster) {
                return @{@"showapi_appid":showPictureAPPid,
                         @"showapi_sign":showPictureSecret
                         };
            }else{
                NSMutableDictionary *FB_dictM = [NSMutableDictionary dictionaryWithDictionary:paramster];
                [FB_dictM setObject:showPictureAPPid forKey:@"showapi_appid"];
                [FB_dictM setObject:showPictureSecret forKey:@"showapi_sign"];
                return FB_dictM;
            }
        }
            break;
        default:
            return nil;
            break;
    }
    
}

+(NSDictionary *)DataToDictionary:(NSData *)data
{
    if (!data) {
        return nil;
    }
    NSString *FB_receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSData * FB_utf8Data = [FB_receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *FB_jsonDict = [NSJSONSerialization JSONObjectWithData:FB_utf8Data options:NSJSONReadingMutableLeaves error:nil];
    
    return FB_jsonDict;
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
