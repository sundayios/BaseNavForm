//
//  FB_GlobalUtlis.m
//  NewsIntegrated01
//
//  Created by lianpu3 on 2018/7/19.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_GlobalUtlis.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>

@implementation FB_GlobalUtlis

+ (void)FB_showNetworkLoading {
    [SVProgressHUD show];
}
+ (void)FB_dismissNetworkLoading {
    [SVProgressHUD dismiss];
}
+ (void)FB_showToast:(NSString *)msg {
    NSLog(@"%@", msg);
    [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:msg duration:1.5 position:CSToastPositionBottom];
}
+ (void)FB_showToastWithStatus:(NSString *)msg {
    NSLog(@"%@", msg);
    [SVProgressHUD showWithStatus:msg];
}
+ (void)FB_showToastSuccessWithStatus:(NSString *)msg {
    NSLog(@"%@", msg);
    [SVProgressHUD showSuccessWithStatus:msg];
}
+ (void)FB_showToastErrorWithStatus:(NSString *)msg {
    NSLog(@"%@", msg);
    [SVProgressHUD showErrorWithStatus:msg];
}
+ (UIImage *)FB_getRandomPlaceholder {
    return [UIImage imageNamed:[NSString stringWithFormat:@"placeholder%u",arc4random() % 206]];
}
+ (NSDictionary *)FB_getXXXParamers:(NSDictionary *)param {
    NSMutableDictionary *FB_MutableDic = param.mutableCopy;
    FB_MutableDic[@"version"] =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    FB_MutableDic[@"type"] = @(1);
    return FB_MutableDic;
}
+(BOOL)FB_M_isOutDate{
#ifdef TIMINGSWITCH
    //当前时间
    NSDate *FB_SP_currentDate = [NSDate date];
    NSTimeInterval  FB_SP_nowTimeS = [FB_SP_currentDate timeIntervalSince1970];
    
    //过时时间
    NSDateFormatter *FB_SP_dateFormatter = [[NSDateFormatter alloc] init];
    [FB_SP_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *FB_SP_outDate = [FB_SP_dateFormatter dateFromString:OUTDATE];
    NSTimeInterval  FB_SP_outDateTimeS = [FB_SP_outDate timeIntervalSince1970];
    
    return FB_SP_nowTimeS-FB_SP_outDateTimeS>0;
#else
    return YES;
#endif
    
}

@end
