//
//  NIPreferenceUtil.h
//  WangCai
//
//  Created by zcx on 2018/7/2.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const subscriptionKey;//订阅的数组

@interface FB_PreferenceUtil : NSObject
+ (void)FB_setGlobalKey:(NSString *)key value:(NSString*)value;
+ (NSString*)FB_getGlobalKey:(NSString *)key;
+ (void)FB_setGlobalArrayKey:(NSString*)key value:(NSArray*)value;
+ (NSArray*)FB_getGlobalArrayKey:(NSString*)key;
@end
