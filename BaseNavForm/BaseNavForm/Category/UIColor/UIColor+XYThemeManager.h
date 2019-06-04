//
//  UIColor+XYThemeManager.h
//
//  Created by ash ash on 18-4-21.
//  Copyright (c) 2018年 zcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XYThemeManager)


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(float)alpha;

/**
 *  主背景色 color1
 *
 *  @return 主背景色
 */
+ (UIColor *)generalBackgroundColor;
+ (UIColor *)color1;

/**
 *  非选中主题色：导航栏,标题栏颜色 color2
 *
 *  @return 非选中主题色：导航栏,标题栏颜色
 */
+ (UIColor *)navgationBarColor;
+ (UIColor *)color2;


/**
 *  搜索栏背景色 color3
 *
 *  @return 搜索栏背景色
 */
+ (UIColor *)searchBarBackgroundColor;
+ (UIColor *)color3;

/**
 *  分割线背景色 color4
 *
 *  @return 分割线背景色
 */
+ (UIColor *)generalLightSeperatorColor;
+ (UIColor *)color4;


/**
 *  输入框提示文字色 color5
 *
 *  @return 输入框提示文字色
 */
+ (UIColor *)generalPlaceHolderColor;
+ (UIColor *)color5;

/**
 *  浅色文字颜色 color6
 *
 *  @return 浅色文字颜色
 */
+ (UIColor *)generalLightTextColor;
+ (UIColor *)color6;

/**
 *  主文字色 color7
 *
 *  @return 主文字色
 */
// 主文字色
+ (UIColor *)generalTextColor;
+ (UIColor *)color7;


/**
 *  黑色背景上面分割线的颜色 color8
 *
 *  @return 黑色背景上面分割线的颜色
 */
+ (UIColor *)generalDarkSeperatorColor;
+ (UIColor *)color8;


/**
 *  主题色 color9
 *
 *  @return 主题色
 */
+ (UIColor *)generalSelectedTintColor;
+ (UIColor *)color9;


/**
 *  通用绿色 color10
 *
 *  @return 通用绿色
 */
+ (UIColor *)generalGreenColor;
+ (UIColor *)color10;

/**
 *  通用蓝色 color11
 *
 *  @return 通用蓝色
 */
+ (UIColor *)generalBlueColor;
+ (UIColor *)color11;

/**
 通用浅蓝色

 @return 通用浅蓝色
 */
+ (UIColor *)generalLightBlueColor;

/**
 *  通用红色 color12
 *
 *  @return 通用红色
 */
+ (UIColor *)generalRedColor;
+ (UIColor *)color12;

/**
 *  通用40%透明黑色 color13
 *
 *  @return 通用40%透明黑色
 */
+ (UIColor *)generalLightBlackColor;
+ (UIColor *)color13;

/**
 *  通用80%透明黑色 color14
 *
 *  @return 通用80%透明黑色
 */
+ (UIColor *)generalDarkBlackColor;
+ (UIColor *)color14;

+(UIColor *)generalGrayColor;

- (NSString *)hexString;

+(UIColor *)generalProgressBackgroundColor;

@end
