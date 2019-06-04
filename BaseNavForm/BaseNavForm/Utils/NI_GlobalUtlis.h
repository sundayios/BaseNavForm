
#import <Foundation/Foundation.h>

@interface NI_GlobalUtlis : NSObject


/**
 show菊花
 */
+ (void)NI_showNetworkLoading;

/**
 hide菊花
 */
+ (void)NI_dismissNetworkLoading;

/**
 展示纯文本提示

 @param msg 文本
 */
+ (void)NI_showToast:(NSString *)msg;

/**
 展示文本+!提示

 @param msg 文本
 */
+ (void)NI_showToastWithStatus:(NSString *)msg;

/**
 展示成功文本提示
 
 @param msg 文本
 */
+ (void)NI_showToastSuccessWithStatus:(NSString *)msg;

/**
 展示失败文本提示
 
 @param msg 文本
 */
+ (void)NI_showToastErrorWithStatus:(NSString *)msg;

/**
 获取随机placeHolder
 */
+ (UIImage *)NI_getRandomPlaceholder;
/**
 设置公共参数

 @param param 传入字典
 @return 加公共参数
 */
+ (NSDictionary *)NI_getXXXParamers:(NSDictionary *)param;
@end
