//
//  AppDelegate+NetworkObserver.m
//  NewsIntegrated01
//
//  Created by lianpu3 on 2018/7/20.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "AppDelegate+NetworkObserver.h"
#import <objc/runtime.h>
#import "AppDelegate+Configuration.h"

#define AppDelegateAlertViewHeight                      NaviBarHeight
#define AppDelegateAlertViewDuration                    0.3
#define AppDelegateNetworkAlerTitleFontSize             15.0f
#define AppDelegateNetworkAlertTag                      999
#define AppDelegateNetworkDisconnectedTitle             @"网络连接已断开"
#define AppDelegateNetworkConnectedTitle                @"已连接互联网"
#define AppDelegateNetwork3GConnectedTitle              @"当前为运营商网络"
#define AppDelegateNetworkWifiConnectedTitle            @"已连接到本地WiFi"

@implementation FB_AppDelegate (NetworkObserver)
@dynamic FB_P_networkStatus, FB_P_isFirstLoad;
static char networkStatusKey;
static char isFirstLoadKey;

- (void)FB_M_startNetworkObserve {
    AFNetworkReachabilityManager *FB_SP_manager = [AFNetworkReachabilityManager sharedManager];
    self.FB_P_networkStatus = FB_SP_manager.networkReachabilityStatus;
    [FB_SP_manager startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FB_M_networkingStatusDidChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)FB_M_networkingStatusDidChanged:(NSNotification*)info{
    NSDictionary *FB_SP_inforDict = [info userInfo];
    NSString *FB_SP_statusStr = [NSObject FB_M_getStringFromDict:FB_SP_inforDict withKey:AFNetworkingReachabilityNotificationStatusItem];
    if (FB_SP_statusStr == nil || [FB_SP_statusStr FB_M_isBlankString]) {
        FB_SP_statusStr = [NSObject FB_M_getStringFromDict:FB_SP_inforDict withKey:@"LCNetworkingReachabilityNotificationStatusItem"];
    }
    NSInteger FB_SP_status   = [FB_SP_statusStr integerValue];
    if (FB_SP_status != AFNetworkReachabilityStatusNotReachable) {
    }
    if (self.FB_P_isFirstLoad == YES) {
        self.FB_P_isFirstLoad = NO;
        self.FB_P_networkStatus = FB_SP_status;
        return;
    }
    if (FB_SP_status == self.FB_P_networkStatus) {
        return;
    }
    self.FB_P_networkStatus = FB_SP_status;
    if (FB_SP_status != AFNetworkReachabilityStatusNotReachable && FB_SP_status != AFNetworkReachabilityStatusUnknown) {
//        [self FB_M_getShow];
        [self networkAlerViewDismiss];
        if (FB_SP_status == AFNetworkReachabilityStatusReachableViaWWAN) {
            [FB_AppDelegate FB_M_show3GNetworkAlert];
        }else if (FB_SP_status == AFNetworkReachabilityStatusReachableViaWiFi){
            [FB_AppDelegate FB_M_showWifiNetworkAlert];
        }else{
            [FB_AppDelegate FB_M_showOtherNetworkAlert];
        }
    }else{
        [FB_AppDelegate FB_M_showNoNetworkAlert];
    }
}

+(FB_AppDelegate*)FB_M_sharedAppDelegate{
    FB_AppDelegate *FB_SP_appDelegate = (FB_AppDelegate*)[UIApplication sharedApplication].delegate;
    return FB_SP_appDelegate;
}
+(void)FB_M_show3GNetworkAlert{
    [self showViewWithTitle:AppDelegateNetwork3GConnectedTitle
                  withImage:[UIImage imageNamed:@"networkConnect"]
        withBackgroundColor:ColorFromSixteen(0xfc6363, 1)];
}
+(void)FB_M_showWifiNetworkAlert{
    [self showViewWithTitle:AppDelegateNetworkWifiConnectedTitle
                  withImage:[UIImage imageNamed:@"networkConnect"]
        withBackgroundColor:ColorFromSixteen(0xfb7272, 1)];
}
+(void)FB_M_showOtherNetworkAlert{
    [self showViewWithTitle:AppDelegateNetworkConnectedTitle
                  withImage:[UIImage imageNamed:@"networkConnect"]
        withBackgroundColor:ColorFromSixteen(0xfb7272, 1)];
}
+(void)FB_M_showNoNetworkAlert{
    [self showViewWithTitle:AppDelegateNetworkDisconnectedTitle
                  withImage:[UIImage imageNamed:@"networkDisconnect"]
        withBackgroundColor:ColorFromSixteen(0x999999, 1)];
}
+(UIView*)showViewWithTitle:(NSString*)title withImage:(UIImage*)image withBackgroundColor:(UIColor*)color{
    UIView *FB_SP_view = [[FB_AppDelegate FB_M_sharedAppDelegate].window viewWithTag:AppDelegateNetworkAlertTag];
    if (FB_SP_view == nil) {
        FB_SP_view = [[UIView alloc] initWithFrame:CGRectMake(0, -MainScreenHeight, MainScreenWidth, AppDelegateAlertViewHeight)];
        [FB_SP_view setTag:AppDelegateNetworkAlertTag];
        [[FB_AppDelegate FB_M_sharedAppDelegate].window addSubview:FB_SP_view];
        UIImageView *FB_SP_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, StatusBarHeight+(NaviBarABXHeight - 25)*0.5, 25, 25)];
        [FB_SP_view addSubview:FB_SP_imageView];
        [FB_SP_imageView setTag:111];
        UILabel *FB_SP_label = [[UILabel alloc] initWithFrame:CGRectMake(50, FB_SP_imageView.frame.origin.y, MainScreenWidth - 60, 25)];
        [FB_SP_label setTextColor:[UIColor whiteColor]];
        [FB_SP_label setFont:[UIFont systemFontOfSize:16]];
        [FB_SP_label setTag:222];
        [FB_SP_view addSubview:FB_SP_label];
    }
    [FB_SP_view setBackgroundColor:color];
    UIImageView *FB_SP_imageView = [FB_SP_view viewWithTag:111];
    if (FB_SP_imageView) {
        [FB_SP_imageView setImage:image];
    }
    UILabel *FB_SP_label = [FB_SP_view viewWithTag:222];
    if (FB_SP_label) {
        [FB_SP_label setText:title];
    }
    [self showView];
    return FB_SP_view;
}
- (void)networkAlerViewDismiss{
    UIView *FB_SP_view = [[FB_AppDelegate FB_M_sharedAppDelegate].window viewWithTag:AppDelegateNetworkAlertTag];
    if (FB_SP_view) {
        [UIView animateWithDuration:AppDelegateAlertViewDuration
                         animations:^{
                             FB_SP_view.frame = CGRectMake(0, -AppDelegateAlertViewHeight, MainScreenWidth, AppDelegateAlertViewHeight);
                         }
                         completion:^(BOOL finished) {
                             if (FB_SP_view && FB_SP_view.superview) {
                                 [FB_SP_view removeFromSuperview];
                             }
                         }];
    }
}
+ (void)showView{
    UIView *FB_SP_view = [[FB_AppDelegate FB_M_sharedAppDelegate].window viewWithTag:AppDelegateNetworkAlertTag];
    if (FB_SP_view) {
        FB_SP_view.frame = CGRectMake(0, - AppDelegateAlertViewHeight, MainScreenWidth, AppDelegateAlertViewHeight);
        [UIView animateWithDuration:AppDelegateAlertViewDuration
                         animations:^{
                             FB_SP_view.frame = CGRectMake(0, 0, MainScreenWidth, AppDelegateAlertViewHeight);
                         }
                         completion:^(BOOL finished) {
                             [[FB_AppDelegate FB_M_sharedAppDelegate] performSelector:@selector(networkAlerViewDismiss)
                                                                           withObject:nil
                                                                           afterDelay:1.5];
                         }];
    }
}

- (void)setFB_P_networkStatus:(AFNetworkReachabilityStatus)FB_P_networkStatus {
    objc_setAssociatedObject(self, &networkStatusKey, @(FB_P_networkStatus), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setFB_P_isFirstLoad:(BOOL)FB_P_isFirstLoad {
    
    objc_setAssociatedObject(self, &isFirstLoadKey, @(FB_P_isFirstLoad), OBJC_ASSOCIATION_ASSIGN);
}
- (AFNetworkReachabilityStatus)FB_P_networkStatus {
    return [objc_getAssociatedObject(self, &networkStatusKey) integerValue];
}
- (BOOL)FB_P_isFirstLoad {
    return [objc_getAssociatedObject(self, &isFirstLoadKey) integerValue];
}
@end
