#import <UIKit/UIKit.h>
@interface FB_NoNetworkAlertView : UIView
{
    UIView *FB_P_noView;
    UIImageView *FB_P_noNetworkAletIcon;
    UILabel *FB_P_noNetworkAlertLabel;
    UILabel *FB_P_alertLabel;
}
- (void)FB_M_reloadCellular;
@end
