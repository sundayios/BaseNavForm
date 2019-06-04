//
//  NIPreferenceUtil.m
//  WangCai
//
//  Created by zcx on 2018/7/2.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import "FB_PreferenceUtil.h"

NSString *const subscriptionKey = @"subscription";


@implementation FB_PreferenceUtil
+ (void)FB_setGlobalKey:(NSString *)key value:(NSString*)value{
    if (FB_IS_STR_NIL(key) || value == nil || value == NULL) {
        return;
    }
    
    NSUserDefaults *FB_userDefault = [NSUserDefaults standardUserDefaults];
    
    [FB_userDefault setObject:value forKey:key];
    [FB_userDefault synchronize];
}

+ (NSString*)FB_getGlobalKey:(NSString *)key
{
    if (FB_IS_STR_NIL(key))
    {
        return nil;
    }
    
    NSString *FB_ret = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return FB_ret;
}
+ (void)FB_setGlobalArrayKey:(NSString*)key value:(NSArray*)value
{
    if (FB_IS_STR_NIL(key))
    {
        return;
    }
    
    NSUserDefaults *FB_userDefault = [NSUserDefaults standardUserDefaults];
    [FB_userDefault setObject:value forKey:key];
    [FB_userDefault synchronize];
}
+ (NSArray*)FB_getGlobalArrayKey:(NSString*)key{
    if (FB_IS_STR_NIL(key))
    {
        return nil;
    }
    
    NSArray *FB_ret = [[NSUserDefaults standardUserDefaults] arrayForKey:key];
    return FB_ret;
}

@end
