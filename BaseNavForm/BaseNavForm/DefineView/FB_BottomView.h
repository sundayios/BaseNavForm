#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FB_E_OperationStyle) {
    FB_E_OperationStyleGoBack = 1000,
    FB_E_OperationStyleGoForward,
    FB_E_OperationStyleRefresh,
    FB_E_OperationStyleHomePage,
    FB_E_OperationStyleMenu
};
@protocol FB_D_BottomViewDelegate <NSObject>
@optional
- (void)FB_M_performOperationWithStyle:(FB_E_OperationStyle)style;
@end
@interface FB_BottomView : UIView
@property (nonatomic,assign) id<FB_D_BottomViewDelegate>delegate;
@end
