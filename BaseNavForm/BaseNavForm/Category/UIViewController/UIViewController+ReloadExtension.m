//
//  UIViewController+ReloadExtension.m
//  CC+
//
//  Created by iGenMO on 2018/7/12.
//  Copyright © 2018年 caichen. All rights reserved.
//

#import "UIViewController+ReloadExtension.h"
#import <Masonry.h>

static int const kReloadImageViewTag = 59533;
static int const kReloadTileLabelTag = 59534;

@implementation UIViewController (ReloadExtension)
@dynamic reloadView;
static char reloadViewKey;

- (void)addReloadClick:(FB_ClickBlock)clickeBlock {
    if (self.reloadView.superview == nil) {
        self.reloadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
        self.reloadView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.reloadView];
        
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"Reload"];
        imageView.tag = kReloadImageViewTag;
        [self.reloadView addSubview:imageView];
//        UIButton *btn = [UIButton buttonWithFrame:CGRectZero title:@"点击重连" fontSize:15 titleColor:[UIColor whiteColor] action:@selector() target:<#(id)#> tag:<#(NSInteger)#> backgroundColor:<#(UIColor *)#>]
        UILabel *label = [UILabel labelWithLableText:@"网络出错,点击重试" size:15 textColor:UIColorFromHex(0x888888) textAlignment:NSTextAlignmentCenter];
        label.tag = kReloadTileLabelTag;
        [self.reloadView addSubview:label];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(self.reloadView).mas_offset(-80);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(20);
            make.centerX.equalTo(self.reloadView);
        }];


        [self.reloadView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            [self reloadAnimation];
            if (clickeBlock) {
                clickeBlock();
            }
        }]];
        [self hideReload];
        
    }
}

- (void)btnAction:(UIButton *)sender {
    
}

- (void)reloadAnimation {
    UIImageView *imageView = [self.view viewWithTag:kReloadImageViewTag];
    UILabel *label = [self.view viewWithTag:kReloadTileLabelTag];
    if (imageView && label) {
        CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
        rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];   // 旋转一周
        rotateAnimation.duration = 2.0;                                 // 旋转时间3秒
        rotateAnimation.repeatCount = MAXFLOAT;                          // 重复次数，这里用最大次数
        
        [imageView.layer addAnimation:rotateAnimation forKey:nil];
    }
}

- (void)showReload {
    [self.view bringSubviewToFront:self.reloadView];
    self.reloadView.hidden = NO;
}

- (void)hideReload {
    [self.view sendSubviewToBack:self.reloadView];
    self.reloadView.hidden = YES;
}


- (UIView *)reloadView {
    return objc_getAssociatedObject(self, &reloadViewKey);
}


- (void)setReloadView:(UIView *)reloadView {
    objc_setAssociatedObject(self, &reloadViewKey, reloadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
