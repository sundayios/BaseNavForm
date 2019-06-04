#import <UIKit/UIKit.h>
typedef void (^FBSplashViewDismissedBlock) (BOOL isFirstLauch);
@interface FB_SplashViewController: UIViewController
@property (strong, nonatomic) FBSplashViewDismissedBlock FB_B_didDismiss;
@end
