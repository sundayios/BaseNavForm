//
//  UIDevice(Identifier).h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)


/*
 * @method uniqueDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 */
- (NSString *)FB_M_uniqueDeviceIdentifier;

/*
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */
- (NSString *)uniqueGlobalDeviceIdentifier;

// Added by mabiao
// 获取UUID
// IOS6一下版本使用mac地址+bundle id进行md5计算获取
// IOS6及以上使用苹果提供的identifierForVendor（此值重装程序后可变化）
- (NSString *)deviceUUID;

// 使用MD5加密后的设备标示符，32位长度
- (NSString *)deviceUUIDHashMD5Length32;

- (NSString *)getCurrentDeviceModel;

@property (nonatomic,copy) NSString *deviceModel;

@end
