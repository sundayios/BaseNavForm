#import "FB_BottomInfoUtil.h"
#import "FB_HttpNetworkUtil+bottomBar.h"
#import "FB_NetworkUtil.h"

@implementation FB_BottomInfoUtil

static FB_BottomInfoUtil *bottomInfoUtil = nil;
+(FB_BottomInfoUtil *)shareSingleTon{
    NSLock *lock = [[NSLock alloc]init];
    [lock lock];
    if (!bottomInfoUtil) {
        bottomInfoUtil = [[FB_BottomInfoUtil alloc]init];
    }
    [lock unlock];
    return bottomInfoUtil;
}


+ (NSURLSessionTask *)fetchBottomBarIconSuccess:(void(^)(void))success
{
    return [FB_NetworkUtil FB_doGetWithURL:kGetbaritembyappid parameters:@{@"id": @"1111"} success:^(NSDictionary *responseDic) {
        NSDictionary *FB_dictDict = responseDic;
        NSArray *FB_codeArr = FB_dictDict[@"code"];
        NSMutableArray *FB_ArrM = @[].mutableCopy;
        NSMutableArray *FB_imageUrls = @[].mutableCopy;
        for (NSDictionary *FB_dict in FB_codeArr) {
            FB_barItem *FB_item = [FB_barItem modelWithJSON:FB_dict];
            [FB_imageUrls addObject:FB_item.barItemHighlightImageUrl];
            [FB_imageUrls addObject:FB_item.barItemNormalImageUrl];
            [FB_ArrM addObject:FB_item];
        }
        [FB_BottomInfoUtil downloadImages:FB_imageUrls completion:^() {
            [[NSUserDefaults standardUserDefaults] setObject:FB_codeArr forKey:@"1111"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSArray *FB_arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"1111"];
            NSLog(@"%@", FB_arr);
            success ? success() : nil;
            
        }];
    } failure: nil];
    
}



+ (void)downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(void))completionBlock {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
    manager.downloadTimeout = 20;
    __block BOOL hadError = NO;
    __block NSMutableArray *resultArrs = @[].mutableCopy;
    for (int i = 0; i<imgsArray.count; i++) {
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        [manager downloadImageWithURL:[NSURL URLWithString:imgsArray[i]] options:SDWebImageDownloaderUseNSURLCache|SDWebImageDownloaderScaleDownLargeImages progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            if (image) {
                [resultArrs addObject:@{@"data": data, @"url": imgsArray[i]}];
            } else {
                hadError = YES;
            }
            
            if (!hadError && resultArrs.count == imgsArray.count) {
                for (NSDictionary *dict in resultArrs) {
                    [[SDImageCache sharedImageCache] storeImageDataToDisk:dict[@"data"] forKey:dict[@"url"]];
                }
                NSLog(@"🔨bottomView按钮图片缓存成功，共%ld张🔨", resultArrs.count);
                if (completionBlock) {
                    completionBlock();
                }
            }
            
            dispatch_semaphore_signal(sema);
        }];
    }
    
}


@end

@implementation FB_barItem

@end

