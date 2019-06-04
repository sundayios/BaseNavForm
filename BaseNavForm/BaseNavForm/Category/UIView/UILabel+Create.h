//
//  UILabel+create.h
//  畅停
//
//  Created by LiaoXingJie on 15/8/13.
//  Copyright (c) 2018年 GuoNing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (Create)

+ (UILabel *) labelWithLableText:(id)labelText
                            size:(CGFloat)size
                       textColor:(UIColor *)textColor
                   textAlignment:(NSTextAlignment)textAlignment;


- (void)borderColor:(UIColor*)borderColor;

-(void)setCornerRadius;

- (void)setLableText:(NSString *)labelText
               size:(CGFloat)size
          textColor:(UIColor *)textColor
      textAlignment:(NSTextAlignment)textAlignment;



@end
