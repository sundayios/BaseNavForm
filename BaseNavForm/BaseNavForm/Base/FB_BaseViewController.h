//
//  FB_BaseViewController.h
//  NewIntegrated01
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 IMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FB_BottomView.h"
#import "FB_ProgressView.h"
#import "FB_NoNetworkAlertView.h"

#define PROGRESS_HEIGHT     4.0f
typedef NS_OPTIONS(NSUInteger, XYNaviBarStyle) {
    TSNaviBarStyleDefault  = 1 << 0,
};

@interface FB_BaseViewController : UIViewController

@property (nonatomic, assign) CGFloat FB_P_startY;

@property (nonatomic,strong) UIButton *FB_P_leftButton;
@property (nonatomic,strong) UIButton *FB_P_rightButton;
@property (nonatomic,strong) UILabel *FB_P_titleLabel;
@property (nonatomic,strong) UIImageView *FB_P_naviBarImagView;
@property (nonatomic,strong) UIView *FB_P_lineTL;

@property (nonatomic,copy,nonnull) NSString *FB_P_urlString;
@property (nonatomic,assign) BOOL FB_P_isShowAlert;
@property (nonatomic,assign) BOOL FB_P_showBottomView;
@property (nonatomic,assign) BOOL FB_P_showNavView;//顶部导航栏
@property (nonatomic,assign) BOOL FB_P_showStatus;
@property (nonatomic,assign) AFNetworkReachabilityStatus FB_P_networkStatus;
@property (nonatomic,strong) FB_BottomView *FB_P_contentBottomView;
@property (nonatomic,strong) FB_ProgressView *FB_P_progressView;
@property (nonatomic,strong) FB_NoNetworkAlertView *FB_P_noNetworkAlertView;

@property (nonatomic, strong) UITextField *FB_P_navSearchTextField;//首页textField。基类默认隐藏
@property (nonatomic, strong) UIButton *FB_P_btnSearch;//搜索按钮。基类默认隐藏

@property (nonatomic, assign)XYNaviBarStyle naviBarStyle;

- (void)FB_M_leftButtonClick:(id)sender;
- (void)FB_M_rightButtonClick:(id)sender;

@property (assign, nonatomic) BOOL isShowing;//当前视图是否在显示，可以拿来判断是否在当前视图来取消或者结束线程


- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notication;

    
- (void)FB_M_image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo;
- (void)FB_M_networkWatingViewDismissFromView:(UIView*)view;
- (BOOL)FB_M_jumpsToThirdAPP:(NSString *)urlStr;
- (void)FB_M_openSuitUrl:(NSURL *)url;
- (void)FB_M_loadMainPageContent;
- (BOOL)FB_M_ifShowNav;
- (void)FB_M_refreshBottomUI;
- (void)FB_M_refreshUrl;
- (void)FB_M_resetContentWebFrame;
@end
