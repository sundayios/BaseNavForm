#import "FB_ProgressView.h"
@implementation FB_ProgressView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CAGradientLayer *FB_SP_gradientLayer = [CAGradientLayer layer];
        FB_SP_gradientLayer.colors = @[(__bridge id)ColorFromSixteen(0x4ad9a4, 1.0).CGColor,
                                 (__bridge id)ColorFromSixteen(0x4ad9a4, 1.0).CGColor,
                                 (__bridge id)ColorFromSixteen(0x4ad9a4, 1.0).CGColor];
        FB_SP_gradientLayer.locations  = @[@0.4,@0.6, @1.0];
        FB_SP_gradientLayer.startPoint = CGPointMake(0, 0);
        FB_SP_gradientLayer.endPoint   = CGPointMake(1.0, 0);
        FB_SP_gradientLayer.frame      = CGRectMake(0, 0, MainScreenWidth, self.frame.size.height);
        [self.layer addSublayer:FB_SP_gradientLayer];
        self.layer.masksToBounds = YES;
    }
    return self;
}
@end
