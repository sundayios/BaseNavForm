//
//  NI_GlobalUtlis.m
//  NewsIntegrated01
//
//  Created by lianpu3 on 2018/7/19.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "NI_GlobalUtlis.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>

@implementation NI_GlobalUtlis

+ (void)NI_showNetworkLoading {
    [SVProgressHUD show];
}
+ (void)NI_dismissNetworkLoading {
    [SVProgressHUD dismiss];
}
+ (void)NI_showToast:(NSString *)msg {
    NSLog(@"%@", msg);
    [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:msg duration:1.5 position:CSToastPositionBottom];
}
+ (void)NI_showToastWithStatus:(NSString *)msg {
    NSLog(@"%@", msg);
    [SVProgressHUD showWithStatus:msg];
}
+ (void)NI_showToastSuccessWithStatus:(NSString *)msg {
    NSLog(@"%@", msg);
    [SVProgressHUD showSuccessWithStatus:msg];
}
+ (void)NI_showToastErrorWithStatus:(NSString *)msg {
    NSLog(@"%@", msg);
    [SVProgressHUD showErrorWithStatus:msg];
}
+ (UIImage *)NI_getRandomPlaceholder {
    return [UIImage imageNamed:[NSString stringWithFormat:@"placeholder%u",arc4random() % 206]];
}
+ (NSDictionary *)NI_getXXXParamers:(NSDictionary *)param {
    NSMutableDictionary *ni_MutableDic = param.mutableCopy;
    ni_MutableDic[@"version"] =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    ni_MutableDic[@"type"] = @(1);
    return ni_MutableDic;
}

@end
