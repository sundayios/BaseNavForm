#import "NSObject+Extension.h"
@implementation NSObject (Extension)
+(BOOL)FB_M_isOrientationPortrait{
    UIInterfaceOrientation FB_SP_interface = [UIApplication sharedApplication].statusBarOrientation;
    if (FB_SP_interface == UIInterfaceOrientationLandscapeLeft || FB_SP_interface == UIInterfaceOrientationLandscapeRight) {
        return NO;
    }
    return YES;
}
+ (NSString *)FB_M_getStringFromDict:(NSDictionary*)dict withKey:(id)key{
    NSString *FB_SP_string = @"";
    if (dict && [dict objectForKey:key]) {
        FB_SP_string = [NSString stringWithFormat:@"%@",[dict objectForKey:key]];
    }
    if (FB_SP_string == nil || [FB_SP_string FB_M_isBlankString]) {
        FB_SP_string = @"";
    }
    return FB_SP_string;
}
@end
