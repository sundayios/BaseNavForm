//
//  FB_BaseViewController.m
//  NewIntegrated01
//
//  Created by IMAC on 2017/6/1.
//  Copyright © 2017年 IMAC. All rights reserved.
//

#import "FB_BaseViewController.h"
#import "FB_UIDefine.h"

@interface FB_BaseViewController ()

@end

@implementation FB_BaseViewController
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.FB_P_showNavView = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden =YES;
    
    _isShowing = YES;
    self.view.backgroundColor = [UIColor generalBackgroundColor];
    
    if (self.FB_P_showNavView) {
        //虚拟navigationBar
        _FB_P_naviBarImagView = [[UIImageView alloc]init];
        _FB_P_naviBarImagView.frame = CGRectMake(0, 0, MainScreenWidth, NAVIGATETION_BAR_MAX_Y);
        _FB_P_naviBarImagView.backgroundColor = [UIColor navgationBarColor];
        _FB_P_naviBarImagView.userInteractionEnabled = YES;
        [self.view addSubview:_FB_P_naviBarImagView];
        
        //装饰线
        CGFloat lineHeight = [FB_UIDefine seperatorLineHeight];
        _FB_P_lineTL = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATETION_BAR_MAX_Y -lineHeight, MainScreenWidth, lineHeight)];
        _FB_P_lineTL.backgroundColor = [UIColor generalLightSeperatorColor];
        [_FB_P_naviBarImagView addSubview:_FB_P_lineTL];
        //标题
        _FB_P_titleLabel = [[UILabel alloc]init];
        [_FB_P_titleLabel setTextColor:[UIColor whiteColor]];
        [_FB_P_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_FB_P_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_FB_P_titleLabel setFont:[UIFont systemFontOfSize:18.0]];
        _FB_P_titleLabel.frame = CGRectMake(50, STATUS_BAR_HEIGHT+5, MainScreenWidth-100, 33);
        [_FB_P_naviBarImagView addSubview:_FB_P_titleLabel];
        //左按钮
        _FB_P_leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _FB_P_leftButton.frame = CGRectMake(11, STATUS_BAR_HEIGHT, 44, 44);
        [_FB_P_leftButton setTitleColor:[UIColor whiteColor] forState:0];
        [_FB_P_leftButton setImage:[UIImage imageNamed:@"previous"] forState:0];
        _FB_P_leftButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_FB_P_leftButton addTarget:self action:@selector(FB_M_leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_FB_P_naviBarImagView addSubview:_FB_P_leftButton];
        //右按钮
        _FB_P_rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _FB_P_rightButton.frame = CGRectMake(MainScreenWidth-52, STATUS_BAR_HEIGHT, 44, 44);
        [_FB_P_rightButton setTitleColor:[UIColor whiteColor] forState:0];
        _FB_P_rightButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_FB_P_rightButton addTarget:self action:@selector(FB_M_rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_FB_P_naviBarImagView addSubview:_FB_P_rightButton];
    }
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification object:nil];
    
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if (vc == self) {
            NSInteger index = [self.navigationController.viewControllers indexOfObject:vc];
            if (0 == index) {
                if (self.navigationController.presentingViewController) {
                     self.FB_P_leftButton.hidden = NO;
                }else{
                     self.FB_P_leftButton.hidden = YES;
                }
               
            }else{
                self.FB_P_leftButton.hidden = NO;
            }
            break;

        }else{
            self.FB_P_leftButton.hidden = YES;
        }
    }
    
    self.naviBarStyle = TSNaviBarStyleDefault;
//
//    [[UIApplication sharedApplication] addObserver:self forKeyPath:@"statusBarFrame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    [[UIApplication sharedApplication] addObserver:self forKeyPath:@"statusBarHidden" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//     [_leftButton addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    NSLog(@"%@监听到%@属性的改变为%@",
//
//          object,keyPath,change);
//
//
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isShowing = YES;
    [self.view bringSubviewToFront:self.FB_P_naviBarImagView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _isShowing = NO;

}

- (void)FB_M_leftButtonClick:(id)sender{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
//    if (self.navigationController.topViewController == self) {
//        [self.navigationController popViewControllerAnimated:YES];
//    } else {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
}
- (void)keyboardWillHide:(NSNotification *)notication{
    
}

- (void)FB_M_rightButtonClick:(id)sender {
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
    
    

#pragma mark 图片保存的回调
- (void)FB_M_image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (error == nil) {
        [FB_GlobalUtlis FB_showToastSuccessWithStatus:@"图片保存成功"];
    }else{
        UIAlertController *FB_SP_controller = [UIAlertController alertControllerWithTitle:@"图片保存失败，无法访问相册"
                                                                                   message:@"请在“设置>隐私>照片”打开相册访问权限"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
        [FB_SP_controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:FB_SP_controller animated:YES completion:nil];
    }
}

- (void)FB_M_networkWatingViewDismissFromView:(UIView*)view{
    if (self.FB_P_progressView) {
        self.FB_P_progressView.hidden = YES;
    }
}

- (BOOL)FB_M_jumpsToThirdAPP:(NSString *)urlStr{
    if ([urlStr hasPrefix:@"mqq"] ||
        [urlStr hasPrefix:@"weixin"] ||
        [urlStr hasPrefix:@"alipay"]) {
        BOOL FB_SP_success = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]];
        if (FB_SP_success) {
            [self FB_M_openSuitUrl:[NSURL URLWithString:urlStr]];
        }else{
            NSString *FB_SP_appurl = [urlStr hasPrefix:@"alipay"]?@"https://itunes.apple.com/cn/app/%E6%94%AF%E4%BB%98%E5%AE%9D-%E8%AE%A9%E7%94%9F%E6%B4%BB%E6%9B%B4%E7%AE%80%E5%8D%95/id333206289?mt=8":([urlStr hasPrefix:@"weixin"]?@"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8":@"https://itunes.apple.com/cn/app/qq/id444934666?mt=8");
            NSString *FB_SP_title = [urlStr hasPrefix:@"mqq"]?@"QQ":([urlStr hasPrefix:@"weixin"]?@"微信":@"支付宝");
            NSString *FB_SP_titleString = [NSString stringWithFormat:@"该设备未安装%@客户端",FB_SP_title];
            UIAlertController *FB_SP_controller = [UIAlertController alertControllerWithTitle:nil message:FB_SP_titleString preferredStyle:UIAlertControllerStyleAlert];
            [FB_SP_controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [FB_SP_controller addAction:[UIAlertAction actionWithTitle:@"立即安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *FB_SP_url = [NSURL URLWithString:FB_SP_appurl];
                [self FB_M_openSuitUrl:FB_SP_url];
            }]];
            [self presentViewController:FB_SP_controller animated:YES completion:nil];
        }
        return YES;
    }
    return NO;
}
    
- (void)FB_M_openSuitUrl:(NSURL *)url {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}
    
- (void)FB_M_loadMainPageContent{
    
}
    
- (BOOL)FB_M_ifShowNav
{
    return self.FB_P_showBottomView && IsPortrait;
}
    
- (void)FB_M_refreshBottomUI{
    BOOL FB_SP_haveBottom = [self FB_M_ifShowNav];
    CGFloat FB_SP_height  = FB_SP_haveBottom?TabBarHeight:NaviBarHeight;
    CGFloat FB_SP_originY = FB_SP_haveBottom?(SCREEN_HEIGHT - FB_SP_height):SCREEN_HEIGHT;
    self.FB_P_contentBottomView.frame = CGRectMake(0, FB_SP_originY, MainScreenWidth, FB_SP_height);
    [self FB_M_resetContentWebFrame];
    
    if (self.FB_P_showBottomView) {
        _FB_P_contentBottomView.frame = CGRectMake(0, SCREEN_HEIGHT - TabBarHeight, MainScreenWidth, TabBarHeight);
    }else{
        _FB_P_contentBottomView.frame = CGRectZero;
    }
    _FB_P_contentBottomView.hidden = !FB_SP_haveBottom;
}
    
- (void)FB_M_refreshUrl {
    
}
- (void)FB_M_resetContentWebFrame {

}
#pragma mark -------------------------  底部
- (FB_BottomView *)FB_P_contentBottomView {
    if (_FB_P_contentBottomView == nil) {
        _FB_P_contentBottomView = [[FB_BottomView alloc] init];
        [self FB_M_refreshBottomUI];
    }
    return _FB_P_contentBottomView;
}
    

- (void)setFB_P_showBottomView:(BOOL)FB_haveNavBar {
    _FB_P_showBottomView = FB_haveNavBar;
    [self FB_M_refreshBottomUI];
}

#pragma mark -------------------------  进度条
- (FB_ProgressView *)FB_P_progressView{
    if (_FB_P_progressView == nil) {
        _FB_P_progressView = [[FB_ProgressView alloc] initWithFrame:CGRectMake(0, NaviBarHeight, 0, PROGRESS_HEIGHT)];
        [self.view addSubview:_FB_P_progressView];
    }
    [self.view bringSubviewToFront:_FB_P_progressView];
    return _FB_P_progressView;
}   
    
#pragma mark - Setters
- (void)setFB_P_urlString:(NSString *)FB_urlString
{
    _FB_P_urlString = FB_urlString;
    if(FB_IS_STR_NOT_NIL(FB_urlString)){
        [self FB_M_loadMainPageContent];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
