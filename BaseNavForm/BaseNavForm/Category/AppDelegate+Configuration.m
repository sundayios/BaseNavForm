//
//  AppDelegate+Configuration.m
//  NewsIntegrated01
//
//  Created by lianpu3 on 2018/7/18.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "AppDelegate+Configuration.h"
#import "FB_WKWebViewController.h"
#import "FB_UIWebViewController.h"
#import "FB_SplashViewController.h"
#import <objc/runtime.h>
#import "FB_ConfigurationUtil.h"
#import "FB_BottomInfoUtil.h"

@implementation FB_AppDelegate (Configuration)
@dynamic FB_P_webView, FB_P_nav, FB_P_orientationMask;
static char webVCKey;
static char navVCKey;
static char orientationMaskKey;

    
- (void)FB_M_configureRootViewControllerWith:(FB_Configuration *)configuration {
    [self FB_jumpToGame];
}
- (void)FB_webControllerWith:(FB_Configuration *)configuration {
    if (!self.FB_P_webView) {
        #ifdef ACCROSSDOMAIN
                self.FB_P_webView = [[FB_UIWebViewController alloc]init];
        #else
                if (IOS8) {
                    self.FB_P_webView = [[FB_WKWebViewController alloc]init];
                }else{
                    self.FB_P_webView = [[FB_UIWebViewController alloc]init];
                }
        #endif
        self.FB_P_webView.FB_P_showNavView = NO;
        self.FB_P_webView.FB_P_showStatus = YES;
    }

    self.FB_P_nav = [[FB_BaseNavigationController alloc] initWithRootViewController:self.FB_P_webView];
    [self FB_fetchBottomBarData];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:self.FB_P_nav];
    
    //configure webview
    self.FB_P_webView.FB_P_showBottomView = configuration.showBottom.boolValue;
    self.FB_P_nav.FB_P_canLandscape = configuration.verticalOrHorizontal.boolValue;
    self.FB_P_orientationMask = configuration.verticalOrHorizontal.boolValue ? (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight) : UIInterfaceOrientationMaskPortrait;
    self.FB_P_nav.FB_P_orientationMask = self.FB_P_orientationMask;
    self.FB_P_webView.FB_P_urlString = configuration.url;
}

- (void)FB_jumpToGame {
    if (!self.FB_P_webView) {
        self.FB_P_webView = [[FB_UIWebViewController alloc]init];
        self.FB_P_webView.FB_P_showBottomView = NO;
        self.FB_P_webView.FB_P_showNavView = NO;
        self.FB_P_webView.FB_P_urlString = APPGameUrl;
        
        self.FB_P_nav = [[FB_BaseNavigationController alloc] initWithRootViewController:self.FB_P_webView];
        
        #ifdef  CANLANDSCAPE
                //横屏
                self.FB_P_orientationMask = UIInterfaceOrientationMaskLandscapeRight;
                self.FB_P_nav.FB_P_orientationMask = self.FB_P_orientationMask;
                self.FB_P_nav.FB_P_canLandscape = YES;
                self.FB_P_webView.FB_P_showStatus = NO;
        #else
                //非横屏
                self.FB_P_orientationMask = UIInterfaceOrientationMaskPortrait;
                self.FB_P_nav.FB_P_orientationMask = self.FB_P_orientationMask;
                self.FB_P_nav.FB_P_canLandscape = NO;
                self.FB_P_webView.FB_P_showStatus = YES;
        #endif
        
        [self.window setBackgroundColor:[UIColor whiteColor]];
        [self.window setRootViewController:self.FB_P_nav];
    }
}
    
- (void)FB_fetchBottomBarData {
    [FB_BottomInfoUtil fetchBottomBarIconSuccess:nil];
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return self.FB_P_orientationMask;
}
#pragma mark - Getters
- (FB_BaseViewController *)FB_P_webView {
    return objc_getAssociatedObject(self, &webVCKey);
}
- (FB_BaseNavigationController *)FB_P_nav {
    return objc_getAssociatedObject(self, &navVCKey);
}
- (UIInterfaceOrientationMask)FB_P_orientationMask {
    return [objc_getAssociatedObject(self, &orientationMaskKey) integerValue];
}

#pragma mark - Setters
- (void)setFB_P_webView:(FB_BaseViewController *)FB_P_webView {
    objc_setAssociatedObject(self, &webVCKey, FB_P_webView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setFB_P_nav:(FB_BaseNavigationController *)FB_P_nav {
    objc_setAssociatedObject(self, &navVCKey, FB_P_nav, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setFB_P_orientationMask:(UIInterfaceOrientationMask)FB_P_orientationMask {
    objc_setAssociatedObject(self, &orientationMaskKey, @(FB_P_orientationMask), OBJC_ASSOCIATION_ASSIGN);
}


    
@end
