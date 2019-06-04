#import "FB_BottomView.h"
#import "FB_BottomInfoUtil.h"
@interface FB_BottomView ()
{
    UIView *FB_P_lineView;
    NSMutableArray *FB_P_buttonsArray;
    NSArray *FB_SP_imageNameArr;
}
@end
@implementation FB_BottomView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        FB_P_buttonsArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self FB_M_createSubViews];
        [self configureButtonWithDiskData];
    }
    return self;
}
- (void)configureButtonWithDiskData {
    NSArray *FB_M_Arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"1111"];
    NSLog(@"%@", FB_M_Arr);
    if (FB_M_Arr) {
        NSMutableArray *arr = @[].mutableCopy;
        for (NSDictionary *dict in FB_M_Arr) {
            FB_barItem *model = [FB_barItem modelWithJSON:dict];
            
            [arr addObject:model];
        }
        if (arr.count <= FB_P_buttonsArray.count) {
            for (FB_barItem *item in arr) {
                if (item.enable.boolValue) {
                    UIButton *btn = FB_P_buttonsArray[[item.barItemIndex integerValue]];
                    UIImage *image_normal = [UIImage imageNamed:FB_SP_imageNameArr[[item.barItemIndex integerValue]]];
                    UIImage *image_highlight = [UIImage imageNamed:[FB_SP_imageNameArr[[item.barItemIndex integerValue]] stringByAppendingString:@"h"]];
                    if ([[SDImageCache sharedImageCache] diskImageDataExistsWithKey:item.barItemNormalImageUrl]) {
                        image_normal = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.barItemNormalImageUrl];
                    }
                    if ([[SDImageCache sharedImageCache] diskImageDataExistsWithKey:item.barItemHighlightImageUrl]) {
                        image_highlight = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.barItemHighlightImageUrl];
                    }
                    [btn setImage:image_normal forState:UIControlStateNormal];
                    [btn setImage:image_highlight forState:UIControlStateHighlighted];
                }
                
            }
        }
        
    }
}
- (void)FB_M_createSubViews{
    NSArray *FB_SP_imageNameArr = @[@"wbackForword",@"wforword",@"wRefresh",@"whomePage",@"wuserother"];
    NSInteger FB_SP_count = FB_SP_imageNameArr.count;
    CGFloat FB_SP_width = self.frame.size.width/FB_SP_count;
    CGFloat FB_SP_height = 49;
    for (int i = 0;i < FB_SP_count; i++) {
        NSString *FB_SP_normal = [FB_SP_imageNameArr objectAtIndex:i];
        NSString *FB_SP_highLight = [FB_SP_normal stringByAppendingString:@"h"];
        UIButton *FB_SP_button = [[UIButton alloc] initWithFrame:CGRectMake(FB_SP_width*i, 0, FB_SP_width, FB_SP_height)];
        [FB_SP_button setImage:[UIImage imageNamed:FB_SP_normal] forState:UIControlStateNormal];
        [FB_SP_button setImage:[UIImage imageNamed:FB_SP_highLight] forState:UIControlStateHighlighted];
        [FB_SP_button addTarget:self action:@selector(FB_M_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [FB_SP_button setTag: (i+1000)];
        [self addSubview:FB_SP_button];
        [FB_P_buttonsArray addObject:FB_SP_button];
    }
    FB_P_lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    [FB_P_lineView setBackgroundColor:ColorFromSixteen(0xb4b4b4, 1)];
    [self addSubview:FB_P_lineView];
}
- (void)FB_M_buttonAction:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(FB_M_performOperationWithStyle:)]) {
        [self.delegate FB_M_performOperationWithStyle:button.tag];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    FB_P_lineView.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    NSInteger FB_SP_count = FB_P_buttonsArray.count;
    CGFloat FB_SP_width = self.frame.size.width/FB_SP_count;
    CGFloat FB_SP_height = 49;
    [FB_P_buttonsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *FB_SP_button = (UIButton*)obj;
        FB_SP_button.frame = CGRectMake(FB_SP_width*idx, 0, FB_SP_width, FB_SP_height);
    }];
}
@end
