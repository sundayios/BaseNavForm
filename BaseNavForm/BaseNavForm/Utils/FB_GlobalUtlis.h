
#import <Foundation/Foundation.h>

@interface FB_GlobalUtlis : NSObject


/**
 show菊花
 */
+ (void)FB_showNetworkLoading;

/**
 hide菊花
 */
+ (void)FB_dismissNetworkLoading;

/**
 展示纯文本提示

 @param msg 文本
 */
+ (void)FB_showToast:(NSString *)msg;

/**
 展示文本+!提示

 @param msg 文本
 */
+ (void)FB_showToastWithStatus:(NSString *)msg;

/**
 展示成功文本提示
 
 @param msg 文本
 */
+ (void)FB_showToastSuccessWithStatus:(NSString *)msg;

/**
 展示失败文本提示
 
 @param msg 文本
 */
+ (void)FB_showToastErrorWithStatus:(NSString *)msg;

/**
 获取随机placeHolder
 */
+ (UIImage *)FB_getRandomPlaceholder;
/**
 设置公共参数

 @param param 传入字典
 @return 加公共参数
 */
+ (NSDictionary *)FB_getXXXParamers:(NSDictionary *)param;
/**
 是否超时
 @return YES是NO否
 */
+(BOOL)FB_M_isOutDate;
@end
