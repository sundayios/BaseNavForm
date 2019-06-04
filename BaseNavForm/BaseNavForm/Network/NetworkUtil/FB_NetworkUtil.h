//
//  NetworkUtil.h
//  CC+
//
//  Created by iGenMO on 2017/8/22.
//  Copyright © 2017年 caichen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FB_NetworkUtil : NSObject

/**
 读取缓存成功的block
 
 @param responseDic 响应体数据
 */
typedef void(^LocalCache)(NSDictionary *responseDic);
/**
 请求成功的block
 
 @param responseDic 响应体数据
 */
typedef void(^RequestSuccess)(id responseDic);
/**
 请求失败的block
 
 @param error 错误信息
 */
typedef void(^RequestFailure)(NSError *error);

/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^RequestProgress)(NSProgress *progress);

/**
 Get请求，默认加密，无缓存

 @param URL url
 @param parameter 参数 @{}
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure;
+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode success:(RequestSuccess)success failure:(RequestFailure)failure;
+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure;
+ (NSURLSessionTask *)FB_doGetWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure;

/**
 Post请求，默认加密，无缓存
 
 @param URL url
 @param parameter 参数 @{}
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionTask
 */
+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure;
+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode success:(RequestSuccess)success failure:(RequestFailure)failure;
+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure;
+ (NSURLSessionTask *)FB_doPostWithURL:(NSString *)URL parameters:(NSDictionary *)parameter needDecode:(BOOL)decode cache:(LocalCache)cache success:(RequestSuccess)success failure:(RequestFailure)failure;



+ (NSURLSessionTask *)FB_uploadImageWithURL:(NSString *)URL parameters:(NSDictionary *)parameters name:(NSString *)name image:(UIImage *)image fileName:(NSString *)fileName imageScale:(CGFloat)imageScale progress:(RequestProgress)progress success:(RequestSuccess)success failure:(RequestFailure)failure;

+ (void)FB_getLocalCacheWithURL:(NSString *)url parameters:(NSDictionary *)parameters cache:(LocalCache)cache;

//+ (CGFloat)getAllHttpCacheSize;
@end
