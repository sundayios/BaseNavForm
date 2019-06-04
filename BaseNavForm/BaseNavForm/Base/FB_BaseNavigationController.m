#import "FB_BaseNavigationController.h"
@interface FB_BaseNavigationController ()
@end
@implementation FB_BaseNavigationController
- (id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.FB_P_orientationMask = UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
}
- (BOOL)shouldAutorotate{
    return self.FB_P_canLandscape;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.FB_P_orientationMask;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
