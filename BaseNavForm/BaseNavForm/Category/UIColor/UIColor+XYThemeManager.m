//
//  UIColor+XYThemeManager.m
//
//  Created by ash ash on 18-4-21.
//  Copyright (c) 2018年 zcx. All rights reserved.
//

#import "UIColor+XYThemeManager.h"


@implementation UIColor (XYThemeManager)



+ (UIColor *)colorWithHexString:(NSString *)stringToConvert //Added by mabiao for color hex -> float
{
    return [self colorWithHexString:stringToConvert alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(float)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor redColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor redColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  //扫描16进制到int
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (alpha < 0 || alpha > 1.0) {
        alpha = 1.0;
    }
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}



#pragma -mark BRIGHT_THEME_MASTER

// 主背景色
+ (UIColor *)generalBackgroundColor
{
    return [self colorWithHexString:@"f1f1f1"];  // 对应color1
}

+(UIColor *)color1
{
    return [self colorWithHexString:@"f1f1f1"];
}

// 非选中主题色：导航栏,标题栏颜色
+ (UIColor *)navgationBarColor
{
    return [self colorWithHexString:@"007aff"]; // 对应color2
}

+(UIColor *)color2
{
    return [self colorWithHexString:@"007aff"];
}

// 搜索栏背景色
+ (UIColor *)searchBarBackgroundColor
{
    return [self colorWithHexString:@"e4e5e7"]; // 对应color3
}
+ (UIColor *)color3
{
    return [self colorWithHexString:@"e4e5e7"];
}

// 分割线背景色
+ (UIColor *)generalLightSeperatorColor
{
    return [self colorWithHexString:@"f5f5f5"]; // 对应color4
}

+(UIColor *)color4
{
    return [self colorWithHexString:@"c5c5c5"];
}

// 输入框提示文字色
+ (UIColor *)generalPlaceHolderColor
{
    return [self colorWithHexString:@"bbbbbb"]; // 对应color5
}

+(UIColor *)color5
{
    return [self colorWithHexString:@"bbbbbb"];
}

// 浅色文字颜色
+ (UIColor *)generalLightTextColor
{
    return [self colorWithHexString:@"888888"]; // 对应color6
}
+(UIColor *)color6
{
    return [self colorWithHexString:@"888888"];
}

// 主文字色
+ (UIColor *)generalTextColor
{
    return [self colorWithHexString:@"222222"]; // 对应color7
}
+(UIColor *)color7{
    return [self colorWithHexString:@"222222"];
}
// 黑色背景上面分割线的颜色
+ (UIColor *)generalDarkSeperatorColor
{
    return [self colorWithHexString:@"3f3f3f"]; // 对应color8
}

+(UIColor *)color8
{
    return [self colorWithHexString:@"3f3f3f"];
}

// 选中主题色
+ (UIColor *)generalSelectedTintColor
{
    return [self colorWithHexString:@"fd8200"]; // 对应color9
}
+(UIColor *)color9{
    return [self colorWithHexString:@"fd8200"];
}

// 通用绿色
+ (UIColor *)generalGreenColor
{
    return [self colorWithHexString:@"7bc729"]; // 对应color10
}

+(UIColor *)color10{
     return [self colorWithHexString:@"7bc729"];
}

// 通用蓝色
+ (UIColor *)generalBlueColor
{
    return [self colorWithHexString:@"3485fa"]; // 对应color11
}
+(UIColor *)color11
{
    return [self colorWithHexString:@"3485fa"];
}
// 通用浅蓝色
+ (UIColor *)generalLightBlueColor
{
    return [self colorWithHexString:@"39affd"]; // 对应color11
}

// 通用红色
+ (UIColor *)generalRedColor
{
    return [self colorWithHexString:@"e23838"]; // 对应color12
}

+(UIColor *)color12
{
    return [self colorWithHexString:@"e23838"];
}

// 通用40%透明黑色
+ (UIColor *)generalLightBlackColor
{
    return [self colorWithHexString:@"000000" alpha:.4f]; // 对应color13
}
+(UIColor *)color13
{
    return [self colorWithHexString:@"000000" alpha:.4f];
}

// 通用80%透明黑色
+ (UIColor *)generalDarkBlackColor
{
    return [self colorWithHexString:@"000000" alpha:.8f]; // 对应color14
}
+(UIColor *)color14
{
     return [self colorWithHexString:@"000000" alpha:.8f];
}

//通用灰色
+(UIColor *)generalGrayColor
{
    return [self colorWithHexString:@"e6e6e6"];
}

+(UIColor *)generalProgressBackgroundColor
{
    return [self colorWithHexString:@"#DEE4F1"];
}


- (NSString *)hexString
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}


@end
