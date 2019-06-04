//
//  FB_UIDefine.m
//  UVideo-FuZhou-iPhone
//
//  Created by zcx on 15/12/21.
//  Copyright © 2018年 zcx. All rights reserved.
//

#import "FB_UIDefine.h"
#import "UIDevice+IdentifierAddition.h"

@implementation FB_UIDefine

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static FB_UIDefine *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.FB_P_defaultHorImage = [UIImage imageNamed:@"common_default_crossrange"];
        self.FB_P_defaultVerImage = [UIImage imageNamed:@"common_default_vertical"];
        self.FB_P_defaultSquareImage = [UIImage imageNamed:@"common_default_channel_logo"];

    }
    return self;
}


+ (UIImage *)defaultHorPoster
{
    return [FB_UIDefine sharedInstance].FB_P_defaultHorImage;
}

+ (UIImage *)defaultVerPoster
{
    return [FB_UIDefine sharedInstance].FB_P_defaultVerImage;
}

+ (UIImage *)defaultSquarePoster
{
    return [FB_UIDefine sharedInstance].FB_P_defaultSquareImage;
}


+ (CGFloat)generalInsetX
{
    if (DEVICE_IS_IPAD) {
        return 10;
    } else {
        return 8;
    }
}

+ (CGFloat)cellArrowWidth
{
    return 26;
}

+ (CGFloat)categoryScrollViewHeight
{
    return 35;
}

+ (CGFloat)navigationBarHeight
{
    return 44;
}

+ (CGFloat)navigationBarInsetY
{

    return NAVIGATETION_BAR_MAX_Y;
    
}
+ (UIStatusBarStyle)statusBarStyle
{
    return UIStatusBarStyleDefault;
}

+ (CGFloat)verCellLabelHeight
{
    return 34;
}

+ (CGFloat)generalEmptyHintWidth
{
    if (DEVICE_IS_IPAD) {
        return 480;
    } else {
        return 225;
    }
    
}

+ (CGFloat)generalEmptyHintHeight
{
    if (DEVICE_IS_IPAD) {
        return 144;
    } else {
        return 36;
    }
}

+ (CGFloat)verPosterAspectRatio
{
    
#if CCBN_MODULE
    return 2.0/3.0;
#else
#if Scale_3_4
    return 3.0/4.0;
#else
    return 2.0/3.0;
#endif
#endif
    
}

+ (CGFloat)horPosterAspectRatio
{
    return 16.0/9.0;
}

+ (CGFloat)homeTopScrollPosterHeight
{
    return 310;
}

+ (CGFloat)homeCellSpaceX
{
    if (DEVICE_IS_IPHONE) {
        return 4;
    } else {
        return 9;
    }
}

+ (CGFloat)verCellSpaceY
{
    return 6;
}

+ (NSTimeInterval)animationDuration
{
    return 0.3;
}
+ (CGFloat)seperatorLineHeight
{
    CGFloat height = 0.0;
    NSString *device = [[UIDevice currentDevice] getCurrentDeviceModel];
    if ([device isEqualToString:@"iPhone 4 (CDMA)"] || [device isEqualToString:@"iPhone 4S"] ||[device isEqualToString:@"iPhone 5 (GSM)"] || [device isEqualToString:@"iPhone 5 (Global)"] || [device isEqualToString:@"iPhone 5c (GSM)"] || [device isEqualToString:@"iPhone 5c (GSM)"] ||[device isEqualToString:@"iPhone 5c (Global)"] || [device isEqualToString:@"iPhone 6 Plus"] || [device isEqualToString:@"iPhone 6"] || [device isEqualToString:@"iPhone 6s Plus"] ||[device isEqualToString:@"iPhone 7 Plus"] || [device isEqualToString:@"iPhone 8 Plus"] || [device isEqualToString:@"iPhone Simulator"]) {
        height = 1.0;
    }else{
        height = 1.f/[UIScreen mainScreen].scale;
    }
    return height;
}




+ (CGFloat)generalCategoryHeight
{
    return 53.f;
}

+ (CGFloat)remoteTouchModeTopButtonInsetX
{
    return 72;
}

+ (CGFloat)remoteTouchModeTopButtonInsetY
{
    return 18;
}


+ (CGFloat)remoteTouchModeTopButtonWidth
{
    return 60;
}

+ (CGFloat)remoteTouchModeBottomButtonInsetX
{
    return 27;
}

+ (CGFloat)remoteTouchModeBottomButtonInsetY
{
    return 35;
}

+ (CGFloat)remoteTouchModeBottomButtonWidth
{
    return 26;
}

+ (CGFloat)remoteTouchModeLeftTouchViewWidth
{
    return 44;
}

+ (CGFloat)homeHeaderHeight
{
#ifdef SWITCH_LOCATION_415MASTER_GUANGDONG
    return 42;
#else
    return 40;
#endif
}

+ (UIEdgeInsets)recMoreCVInsets
{
#if defined(SWITCH_LOCATION_SHANXI) || defined(SWITCH_LOCATION_415MASTER) || defined(SWITCH_LOCATION_415MASTER_GUANGDONG) || defined(SWITCH_LOCATION_SHANDONG) || defined(SWITCH_LOCATION_CHANGSHA) || defined(SWITCH_LOCATION_SICHUAN_BASE415)
    return UIEdgeInsetsMake(10, 8, 10, 8);
#else
    return UIEdgeInsetsMake(10, 10, 10, 10);
#endif
}

+ (CGFloat)recMoreCVHeaderHeight
{
#if defined(SWITCH_LOCATION_SHANXI) || defined(SWITCH_LOCATION_415MASTER) || defined(SWITCH_LOCATION_415MASTER_GUANGDONG) || defined(SWITCH_LOCATION_SHANDONG) || defined(SWITCH_LOCATION_CHANGSHA) || defined(SWITCH_LOCATION_SICHUAN_BASE415)
    return 0;
#else
    return 30;
#endif
}


+ (CGFloat)recMoreCellExtraHeight
{
#if defined(SWITCH_LOCATION_SHANXI) || defined(SWITCH_LOCATION_415MASTER) || defined(SWITCH_LOCATION_415MASTER_GUANGDONG) || defined(SWITCH_LOCATION_SHANDONG) || defined(SWITCH_LOCATION_CHANGSHA) || defined(SWITCH_LOCATION_SICHUAN_BASE415)
    return 34;
#else
    return 25 + 16;
#endif
}


@end
