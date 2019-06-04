#import "FB_SplashViewController.h"
#import "FB_NoNetworkAlertView.h"
#import "AppDelegate+Configuration.h"
#import "FB_ConfigurationUtil.h"
#import "UIViewController+ReloadExtension.h"
@interface FB_SplashViewController ()
{
    BOOL _FB_TryToLeaveWithNetworkError;
}
@property (nonatomic, strong) FB_NoNetworkAlertView *FB_P_noNetworkAlertView;
@property (strong, nonatomic)UIImageView *loadingImageView;
@end
@implementation FB_SplashViewController
{
    UIPageControl  *_FB_P_pageControl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _loadingImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    [self.loadingImageView setImage:[UIImage imageNamed:@"LaunchImage.png"]];
    
//    [self.view addSubview:_loadingImageView];
//    [self.view sendSubviewToBack:_loadingImageView];
    
    [self.view addSubview:self.FB_P_noNetworkAlertView];
    FB_WEAKSELF(weakSelf);
    [self addReloadClick:^{
        STRONGSELF
        [strongSelf FB_getConfiguration];
    }];
    
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        STRONGSELF
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
            {
                strongSelf.FB_P_noNetworkAlertView.hidden = NO;
                [strongSelf.FB_P_noNetworkAlertView FB_M_reloadCellular];
                [strongSelf.view bringSubviewToFront:strongSelf.FB_P_noNetworkAlertView];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                strongSelf.FB_P_noNetworkAlertView.hidden = YES;
                if (strongSelf -> _FB_TryToLeaveWithNetworkError) {
                    
                }else{
                    [strongSelf FB_getConfiguration];
                }
                
            }
                break;
            default:
                break;
        }
    }];
}
- (void)FB_getConfiguration {
    [((FB_AppDelegate *)([UIApplication sharedApplication].delegate)) FB_M_configureRootViewControllerWith:nil];
    [self hideReload];
    
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status !=AFNetworkReachabilityStatusUnknown || AFNetworkReachabilityStatusNotReachable) {
        [self performSelector:@selector(FB_M_shouldDismiss:) withObject:self afterDelay:3];
    }else{
        _FB_TryToLeaveWithNetworkError = YES;
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger FB_SP_scrollIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
    [_FB_P_pageControl setCurrentPage:FB_SP_scrollIndex];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)dismiss:(BOOL)isFirst
{
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)FB_M_shouldDismiss:(BOOL)isFirst
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.FB_B_didDismiss) {
            self.FB_B_didDismiss(isFirst);
            self.FB_B_didDismiss = nil;
        }
    });
}
-(BOOL)shouldAutorotate
{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (FB_NoNetworkAlertView *)FB_P_noNetworkAlertView {
    if (!_FB_P_noNetworkAlertView) {
        _FB_P_noNetworkAlertView = [[FB_NoNetworkAlertView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, SCREEN_HEIGHT - TabBarHeight)];
        [_FB_P_noNetworkAlertView FB_M_reloadCellular];
        _FB_P_noNetworkAlertView.hidden = YES;
    }
    return _FB_P_noNetworkAlertView;
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:nil];
    NSLog(@"SplashViewController dealloc");
}
@end
