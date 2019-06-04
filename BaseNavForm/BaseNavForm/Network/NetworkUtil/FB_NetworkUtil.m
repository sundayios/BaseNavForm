
#import "FB_NetworkUtil.h"
#import "PPNetworkHelper.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AESCipher.h"

@implementation FB_NetworkUtil


/*
 配置好PPNetworkHelper各项请求参数,封装成一个公共方法,给以上方法调用,
 相比在项目中单个分散的使用PPNetworkHelper/其他网络框架请求,可大大降低耦合度,方便维护
 在项目的后期, 你可以在公共请求方法内任意更换其他的网络请求工具,切换成本小
 */

#pragma mark - 请求的公共方法
+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure {
    return [self FB_doGetWithURL:URL parameters:parameter needDecode:YES cache:nil success:success failure:failure];
}

+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure {
    return [self FB_doGetWithURL:URL parameters:parameter needDecode:YES cache:cache success:success failure:failure];
}

+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode success:(RequestSuccess)success failure:(RequestFailure)failure {
    return [self FB_doGetWithURL:URL parameters:parameter needDecode:decode cache:nil success:success failure:failure];
}

+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerHTTP];
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
//    [PPNetworkHelper setValue:@"9" forHTTPHeaderField:@"fromType"];
    NSDictionary *FB_parame = [FB_GlobalUtlis FB_getXXXParamers:parameter];

    // 发起请求
    NSURLSessionTask *FB_task = [PPNetworkHelper GET:[self combineRequestApi:URL] parameters:FB_parame responseCache:^(id responseCache) {
        if (![responseCache isKindOfClass:[NSNull class]] && responseCache && cache) {
            NSDictionary *responseDic = decode ? [FB_NetworkUtil transfromJsonData:responseCache decode:decode] : responseCache;
            if ([responseDic[@"status"] integerValue] == 0) {
                cache(responseDic);
            }
        }
    } success:^(id responseObject) {
        
        [FB_GlobalUtlis FB_dismissNetworkLoading];
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        id FB_aResponseObj = [FB_NetworkUtil transfromJsonData:responseObject decode:decode];
        if ([FB_aResponseObj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDic = FB_aResponseObj;
            NSLog(@"%@\nparameters = %@\nresponseObject = %@", [self combineRequestApi:URL], FB_parame, FB_aResponseObj);
            if ([responseDic[@"status"] integerValue] == 0) {
                success ? success(responseDic) : nil;
            } else {
                [FB_GlobalUtlis FB_showToast:responseDic[@"errorMessage"]];
                NSLog(@"%@",responseDic[@"errorMessage"]);
                NSError *error = [NSError errorWithDomain:[self combineRequestApi:URL] code:[responseDic[@"status"] integerValue] userInfo:responseDic];
                failure ? failure(error) : nil;
            }
        } else if ([FB_aResponseObj isKindOfClass:[NSString class]]) {
#pragma mark - todo
            //未定义
        } else {
            NSLog(@"json解析异常⚠️⚠️⚠️⚠️url=%@\nparameters = %@\nresponseObject = %@", URL, FB_parame, responseObject);
            
        }
    } failure:^(NSError *error) {
        [FB_GlobalUtlis FB_dismissNetworkLoading];
        NSLog(@"⚠️⚠️⚠️⚠️%@\nparameters = %@\nerror = %@",URL,FB_parame,error);
        [FB_GlobalUtlis FB_showToast:error.localizedDescription];
        failure ? failure(error) : nil;
    }];

    NSLog(@"🍕Get请求Url %@",FB_task.currentRequest.URL.absoluteString);
    return FB_task;
}

+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure
{
    return [self FB_doPostWithURL:URL parameters:parameter needDecode:YES cache:nil success:success failure:failure];
}
+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode success:(RequestSuccess)success failure:(RequestFailure)failure {
    return [self FB_doPostWithURL:URL parameters:parameter needDecode:decode cache:nil success:success failure:failure];
}
+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure {
    return [self FB_doPostWithURL:URL parameters:parameter needDecode:YES cache:cache success:success failure:failure];
}
+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerHTTP];
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
//    [PPNetworkHelper setValue:@"9" forHTTPHeaderField:@"fromType"];
    NSDictionary *FB_parame = [FB_GlobalUtlis FB_getXXXParamers:parameter];
    // 发起请求
    NSURLSessionTask *FB_task = [PPNetworkHelper POST:[self combineRequestApi:URL] parameters:FB_parame responseCache:^(id responseCache) {
        if (![responseCache isKindOfClass:[NSNull class]] && responseCache && cache) {
            NSDictionary *responseDic = decode ? [FB_NetworkUtil transfromJsonData:responseCache decode:decode] : responseCache;
            if ([responseDic[@"status"] integerValue] == 0) {
                cache(responseDic);
            }
        }
    }  success:^(id responseObject) {
        [FB_GlobalUtlis FB_dismissNetworkLoading];
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        id FB_aResponseObj = [FB_NetworkUtil transfromJsonData:responseObject decode:decode];
        if ([FB_aResponseObj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDic = FB_aResponseObj;
            NSLog(@"%@\nparameters = %@\nresponseObject = %@", [self combineRequestApi:URL], FB_parame, FB_aResponseObj);
            if ([responseDic[@"status"] integerValue] == 0) {
                success ? success(responseDic) : nil;
            } else {
                [FB_GlobalUtlis FB_showToast:responseDic[@"errorMessage"]];
                NSLog(@"%@",responseDic[@"errorMessage"]);
                NSError *error = [NSError errorWithDomain:[self combineRequestApi:URL] code:[responseDic[@"status"] integerValue] userInfo:responseDic];
                failure ? failure(error) : nil;
            }
        } else if ([FB_aResponseObj isKindOfClass:[NSString class]]) {
#pragma mark - todo
            //未定义
        } else {
            NSLog(@"json解析异常⚠️⚠️⚠️⚠️url=%@\nparameters = %@\nresponseObject = %@", URL, FB_parame, responseObject);
        }
    } failure:^(NSError *error) {
        [FB_GlobalUtlis FB_dismissNetworkLoading];
        NSLog(@"⚠️⚠️⚠️⚠️%@\nparameters = %@\nerror = %@",URL,FB_parame,error);
        [FB_GlobalUtlis FB_showToast:error.localizedDescription];
        failure ? failure(error) : nil;
    }];

    return FB_task;
}

+ (NSURLSessionTask *)FB_uploadImageWithURL:(NSString *)URL parameters:(NSDictionary *)parameters name:(NSString *)name image:(UIImage *)image fileName:(NSString *)fileName imageScale:(CGFloat)imageScale progress:(RequestProgress)progress success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [FB_GlobalUtlis FB_showNetworkLoading];
//    NSDictionary *parame = [MyUtils getXXParame:parameters];
    NSDictionary *FB_parame = parameters;

    AFHTTPSessionManager *_FB_sessionManager = [AFHTTPSessionManager manager];
    _FB_sessionManager.requestSerializer.timeoutInterval = 30.f;
    _FB_sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    NSURLSessionTask *sessionTask = [_FB_sessionManager POST:[self combineRequestApi:URL] parameters:FB_parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        // 图片经过等比压缩后得到的二进制文件
//        UIImage *tempImage = [MyUtils compressImage:image toByte:3*1024];
        UIImage *FB_tempImage = image;
        NSData *FB_imageData = UIImageJPEGRepresentation(FB_tempImage, 1);
        NSLog(@"图片大小 = %ld",FB_imageData.length);
        // 默认图片的文件名, 若fileNames为nil就使用

        NSDateFormatter *FB_formatter = [[NSDateFormatter alloc] init];
        FB_formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *FB_str = [FB_formatter stringFromDate:[NSDate date]];
        NSString *FB_imageFileName = [NSString stringWithFormat:@"%@.jpg",FB_str];

        [formData appendPartWithFileData:FB_imageData
                                    name:name
                                fileName:FB_imageFileName
                                mimeType:[NSString stringWithFormat:@"image/%@",@"jpg"]];


    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [FB_GlobalUtlis FB_dismissNetworkLoading];
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        NSDictionary *FB_responseDic = responseObject;
        NSLog(@"%@\nparameters = %@\nresponseObject = %@",URL,FB_parame,FB_responseDic);
        if ([FB_responseDic[@"status"] integerValue] == 0) {
            success ? success(FB_responseDic) : nil;
        } else {
            [FB_GlobalUtlis FB_showToast:FB_responseDic[@"errorMessage"]];
            NSLog(@"%@",FB_responseDic[@"errorMessage"]);
            NSError *FB_error = [NSError errorWithDomain:[self combineRequestApi:URL] code:[FB_responseDic[@"status"] integerValue] userInfo:FB_responseDic];
            failure ? failure(FB_error) : nil;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [FB_GlobalUtlis FB_dismissNetworkLoading];
        NSLog(@"%@\nparameters = %@\nerror = %@",URL,FB_parame,error);
        failure ? failure(error) : nil;
    }];

    // 添加sessionTask到数组
//    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;

    return sessionTask;
}

+ (NSString *)combineRequestApi:(NSString *)api {
//    return [NSString stringWithFormat:@"%@%@%@", [GlobalSetting shared].hostUrl, kIneterfacedTypeMobile, api];
    return kRequestURL(api);
}

+ (void)FB_getLocalCacheWithURL:(NSString *)URL parameters:(NSDictionary *)parameters cache:(LocalCache)cacheSuccess
{
    id cache = [PPNetworkCache httpCacheForURL:[self combineRequestApi:URL] parameters:parameters];
    if (![cache isKindOfClass:[NSNull class]] && cache != nil) {
        if (cacheSuccess) {
            cacheSuccess(cache);
        }
    }
}

+ (CGFloat)getAllHttpCacheSize
{
    NSLog(@"网络缓存大小cache = %fKB",[PPNetworkCache getAllHttpCacheSize]/1024.f);
    return [PPNetworkCache getAllHttpCacheSize]/1024.f;
}

+ (id)transfromJsonData:(NSData *)jsonData decode:(BOOL)needDecode {
    if (jsonData == nil) {
        return nil;
    }
    if (needDecode) {
        NSString *FB_utf8Str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *FB_decodeStr = aesDecryptString(FB_utf8Str, kDecryptKey);
        jsonData = [FB_decodeStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    NSError *error;
    id FB_responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        if ([FB_responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = FB_responseObject;
            return responseDict;
        } else if ([FB_responseObject isKindOfClass:[NSString class]]) {
            NSString *responseStr = FB_responseObject;
            return responseStr;
        } else {
//            NSLog(@"⚠️⚠️⚠️⚠️未知数据类型 ====== %@", responseObject);
            return  FB_responseObject;
        }
    } else {
        NSLog(@"⚠️⚠️⚠️⚠️JSON解析失败，请检查数据格式. -- %@", error);
        return nil;
    }
}

@end
