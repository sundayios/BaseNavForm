
#import <UIKit/UIKit.h>
typedef void(^FB_ClickBlock)();

@interface UIViewController (ReloadExtension)

@property (nonatomic, strong) UIView *reloadView;


- (void)addReloadClick:(FB_ClickBlock )clickeBlock;

- (void)showReload;

- (void)hideReload;


@end
