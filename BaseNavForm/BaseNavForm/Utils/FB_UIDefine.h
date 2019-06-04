//
//  FB_UIDefine.h
//
//  Created by zcx on 18/04/21.
//  Copyright © 2018年 zcx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FB_UIDefine : NSObject

@property (strong, nonatomic) UIImage *FB_P_defaultVerImage;
@property (strong, nonatomic) UIImage *FB_P_defaultHorImage;
@property (strong, nonatomic) UIImage *FB_P_defaultSquareImage;

+ (instancetype)sharedInstance;

/**
 *  通用水平缩进数
 *
 *  @return 通用水平缩进数
 */

+ (CGFloat)generalInsetX;

+ (CGFloat)cellArrowWidth;

+ (CGFloat)categoryScrollViewHeight;

+ (CGFloat)navigationBarHeight;

+ (CGFloat)navigationBarInsetY;

+ (UIStatusBarStyle)statusBarStyle;

/**
 *  垂直节目的名字Label的高度（显示两行文字）
 *
 *  @return 高度
 */
+ (CGFloat)verCellLabelHeight;

+ (UIImage *)defaultVerPoster;

+ (UIImage *)defaultHorPoster;

+ (UIImage *)defaultSquarePoster;

/**
 *  无内容提示的宽度
 *
 *  @return 无内容提示的宽度
 */
+ (CGFloat)generalEmptyHintWidth;

+ (CGFloat)generalEmptyHintHeight;

// 竖版海报的宽高比
+ (CGFloat)verPosterAspectRatio;

+ (CGFloat)horPosterAspectRatio;

+ (CGFloat)homeTopScrollPosterHeight;

+ (CGFloat)homeCellSpaceX;

+ (CGFloat)verCellSpaceY;

+ (NSTimeInterval)animationDuration;

// 分割线高度
+ (CGFloat)seperatorLineHeight;


// 分类栏高度
+ (CGFloat)generalCategoryHeight;

+ (CGFloat)remoteTouchModeTopButtonInsetX;
+ (CGFloat)remoteTouchModeTopButtonInsetY;
+ (CGFloat)remoteTouchModeTopButtonWidth;
+ (CGFloat)remoteTouchModeBottomButtonInsetX;
+ (CGFloat)remoteTouchModeBottomButtonInsetY;
+ (CGFloat)remoteTouchModeBottomButtonWidth;
+ (CGFloat)remoteTouchModeLeftTouchViewWidth;


+ (CGFloat)homeHeaderHeight;


// 首页更多推荐
+ (UIEdgeInsets)recMoreCVInsets;
+ (CGFloat)recMoreCVHeaderHeight;

+ (CGFloat)recMoreCellExtraHeight;   //除了海报本身之外的额外高度



@end
