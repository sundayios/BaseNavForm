#import "UILabel+Create.h"


@implementation UILabel (Create)



+ (UILabel *)labelWithLableText:(id)labelText size:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = textColor;
    label.numberOfLines = 0;
    
    if ([labelText isKindOfClass:[NSString class]]) {
        label.text = labelText;
    } else if ([labelText isKindOfClass:[NSAttributedString class]]) {
        label.attributedText = labelText;
    }
    
    return label;
}

- (void)borderColor:(UIColor*)borderColor {
    self.layer.borderWidth = 1;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
}
@end
