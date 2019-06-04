//
//  AppDelegate+Configuration.h
//  NewsIntegrated01
//
//  Created by lianpu3 on 2018/7/18.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_AppDelegate.h"
#import "FB_BaseViewController.h"
#import "FB_BaseNavigationController.h"
@class FB_Configuration;

@interface FB_AppDelegate (Configuration)

@property (nonatomic, strong) FB_BaseViewController *FB_P_webView;
@property (nonatomic, strong) FB_BaseNavigationController *FB_P_nav;
@property (nonatomic, assign) UIInterfaceOrientationMask FB_P_orientationMask;

    
- (void)FB_M_configureRootViewControllerWith:(FB_Configuration *)configuration ;
@end
