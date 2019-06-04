#import "FB_NoNetworkAlertView.h"
#import <CoreTelephony/CTCellularData.h>
@implementation FB_NoNetworkAlertView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self FB_M_createSubViews];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)FB_M_createSubViews{
    FB_P_noView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)];
    [FB_P_noView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:FB_P_noView];
    FB_P_noNetworkAletIcon = [[UIImageView alloc] initWithFrame:CGRectMake((MainScreenWidth - 42)*0.5, 0, 42, 42)];
    [FB_P_noNetworkAletIcon setBackgroundColor:[UIColor clearColor]];
    [FB_P_noNetworkAletIcon setImage:[UIImage imageNamed:@"noNetworkAletIcon"]];
    [FB_P_noView addSubview:FB_P_noNetworkAletIcon];
    FB_P_noNetworkAlertLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(FB_P_noNetworkAletIcon.frame)+15, MainScreenWidth-10, 20)];
    [FB_P_noNetworkAlertLabel setNumberOfLines:0];
    [FB_P_noNetworkAlertLabel setCenter:CGPointMake(FB_P_noView.frame.size.width*0.5, FB_P_noNetworkAlertLabel.center.y)];
    [FB_P_noView addSubview:FB_P_noNetworkAlertLabel];
    [self FB_M_reloadCellular];
}
- (void)FB_M_reloadCellular{
    CTCellularData *FB_SP_cellularData = [[CTCellularData alloc] init];
    FB_SP_cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *FB_SP_str1 = @"WiFi或蜂窝网络已经断开";
            NSString *FB_SP_str2 = @"\n请检查您的网络设置";
            NSString *FB_SP_str3 = @"";
            NSString *FB_SP_str4 = @"";
            if (FB_SP_cellularData.restrictedState == kCTCellularDataRestricted) {
                FB_SP_str1 = @"系统已为此应用关闭无线局域网";
                FB_SP_str2 = @"\n您可以在“";
                FB_SP_str3 = @"设置";
                FB_SP_str4 = @"”中为此应用打开无线局域网";
            }
            NSMutableParagraphStyle *FB_SP_style = [[NSMutableParagraphStyle alloc] init];
            [FB_SP_style setAlignment:NSTextAlignmentCenter];
            [FB_SP_style setLineSpacing:4];
            NSDictionary *FB_SP_dict1 = @{NSForegroundColorAttributeName:ColorFromSixteen(0x222222, 1),
                                   NSFontAttributeName:[UIFont systemFontOfSize:17],
                                   NSParagraphStyleAttributeName:FB_SP_style};
            NSAttributedString *FB_SP_string1 = [[NSAttributedString alloc] initWithString:FB_SP_str1 attributes:FB_SP_dict1];
            NSDictionary *FB_SP_dict2 = @{NSForegroundColorAttributeName:ColorFromSixteen(0x666666, 1),
                                    NSFontAttributeName:[UIFont systemFontOfSize:14],
                                    NSParagraphStyleAttributeName:FB_SP_style};
            NSAttributedString *FB_SP_string2 = [[NSAttributedString alloc] initWithString:FB_SP_str2 attributes:FB_SP_dict2];
            NSAttributedString *FB_SP_string4 = [[NSAttributedString alloc] initWithString:FB_SP_str4 attributes:FB_SP_dict2];
            NSDictionary *FB_SP_dict3 = @{NSForegroundColorAttributeName:ColorFromSixteen(0x175dfc, 1),
                                    NSFontAttributeName:[UIFont systemFontOfSize:14],
                                    NSParagraphStyleAttributeName:FB_SP_style};
            NSAttributedString *FB_SP_string3 = [[NSAttributedString alloc] initWithString:FB_SP_str3 attributes:FB_SP_dict3];
            NSMutableAttributedString *FB_SP_string = [[NSMutableAttributedString alloc] init];
            [FB_SP_string appendAttributedString:FB_SP_string1];
            [FB_SP_string appendAttributedString:FB_SP_string2];
            [FB_SP_string appendAttributedString:FB_SP_string3];
            [FB_SP_string appendAttributedString:FB_SP_string4];
            [self->FB_P_noNetworkAlertLabel setAttributedText:FB_SP_string];
            CGRect FB_SP_frame = [FB_SP_string boundingRectWithSize:CGSizeMake(MainScreenWidth - 10, NSIntegerMax) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            self->FB_P_noNetworkAlertLabel.frame = CGRectMake(5, CGRectGetMaxY(self->FB_P_noNetworkAletIcon.frame)+15, MainScreenWidth-10, FB_SP_frame.size.height);
            self->FB_P_noView.frame  = CGRectMake(0, 0, MainScreenWidth, CGRectGetMaxY(self->FB_P_noNetworkAlertLabel.frame));
            self->FB_P_noView.center = CGPointMake(self->FB_P_noView.center.x, self.frame.size.height*0.5 - 50);
        });
    };
}
- (void)layoutSubviews{
    [super layoutSubviews];
    FB_P_noNetworkAletIcon.frame = CGRectMake((MainScreenWidth - 42)*0.5, 0, 42, 42);
    FB_P_noNetworkAlertLabel.frame = CGRectMake(5, CGRectGetMaxY(FB_P_noNetworkAletIcon.frame)+15, MainScreenWidth-10, FB_P_noNetworkAlertLabel.frame.size.height);
    FB_P_noView.frame  = CGRectMake(0, 0, MainScreenWidth, CGRectGetMaxY(FB_P_noNetworkAlertLabel.frame));
    FB_P_noView.center = CGPointMake(FB_P_noView.center.x, self.frame.size.height*0.5 - 20);
}
@end
