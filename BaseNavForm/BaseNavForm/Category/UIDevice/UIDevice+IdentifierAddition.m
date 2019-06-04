//
//  UIDevice(Identifier).m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"
#import <CocoaSecurity.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@interface UIDevice(Private)

- (NSString *) macaddress;

@end

@implementation UIDevice (IdentifierAddition)

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods

- (NSString *) FB_M_uniqueDeviceIdentifier{
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
    
    NSString *uniqueIdentifier = [CocoaSecurity md5:stringToHash].hexLower;
    uniqueIdentifier =[uniqueIdentifier stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return uniqueIdentifier;
}

- (NSString *) uniqueGlobalDeviceIdentifier{
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
    NSString *uniqueIdentifier = [CocoaSecurity md5:macaddress].hexLower;
    uniqueIdentifier = [uniqueIdentifier stringByReplacingOccurrencesOfString:@" " withString:@""];
    return uniqueIdentifier;
}

- (NSString *)deviceUUID
{
    if (SYSTEM_VERSION_LESS_THAN(@"6.0"))
        return [[UIDevice currentDevice] FB_M_uniqueDeviceIdentifier];
    else
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)deviceUUIDHashMD5Length32
{
    NSString *TSDeviceUUID = [CocoaSecurity md5:[self deviceUUID]].hexLower;
    TSDeviceUUID = [TSDeviceUUID stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([TSDeviceUUID length] > 32) {
        TSDeviceUUID = [TSDeviceUUID substringToIndex:32];
    }
    
    return TSDeviceUUID;
}

static NSString *deviceModel = @"deviceModel";

- (void)setDeviceModel:(NSString *)deviceModel
{
    objc_setAssociatedObject(self, &deviceModel, deviceModel, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)deviceModel
{
     return  objc_getAssociatedObject(self, &deviceModel);
}


- (NSString *)getCurrentDeviceModel
{
    if (FB_IS_STR_NOT_NIL(self.deviceModel)) {
        return deviceModel;
    }
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *modelIdentifier = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    // 参考页面：https://github.com/erichoracek/UIDevice-Hardware/blob/master/UIDevice-Hardware.m，后续设备更新后可以更新此代码
    
    if ([modelIdentifier isEqualToString:@"iPhone1,1"])    return self.deviceModel = @"iPhone 1G";
    if ([modelIdentifier isEqualToString:@"iPhone1,2"])    return self.deviceModel =@"iPhone 3G";
    if ([modelIdentifier isEqualToString:@"iPhone2,1"])    return self.deviceModel =@"iPhone 3GS";
    if ([modelIdentifier isEqualToString:@"iPhone3,1"])    return self.deviceModel =@"iPhone 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone3,2"])    return self.deviceModel =@"iPhone 4 (GSM Rev A)";
    if ([modelIdentifier isEqualToString:@"iPhone3,3"])    return self.deviceModel =@"iPhone 4 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPhone4,1"])    return self.deviceModel =@"iPhone 4S";
    if ([modelIdentifier isEqualToString:@"iPhone5,1"])    return self.deviceModel =@"iPhone 5 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,2"])    return self.deviceModel =@"iPhone 5 (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone5,3"])    return self.deviceModel =@"iPhone 5c (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,4"])    return self.deviceModel =@"iPhone 5c (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone6,1"])    return self.deviceModel =@"iPhone 5s (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone6,2"])    return self.deviceModel =@"iPhone 5s (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone7,1"])    return self.deviceModel =@"iPhone 6 Plus";
    if ([modelIdentifier isEqualToString:@"iPhone7,2"])    return self.deviceModel =@"iPhone 6";
    if ([modelIdentifier isEqualToString:@"iPhone8,1"])    return self.deviceModel =@"iPhone 6s";
    if ([modelIdentifier isEqualToString:@"iPhone8,2"])    return self.deviceModel =@"iPhone 6s Plus";
    if ([modelIdentifier isEqualToString:@"iPhone8,4"])    return self.deviceModel =@"iPhone SE";
    if ([modelIdentifier isEqualToString:@"iPhone9,2"])    return self.deviceModel =@"iPhone 7 Plus";
    if ([modelIdentifier isEqualToString:@"iPhone9,3"])    return self.deviceModel =@"iPhone 7";
    if ([modelIdentifier isEqualToString:@"iPhone10,1"])   return self.deviceModel =@"iPhone 8";          // US (Verizon), China, Japan
    if ([modelIdentifier isEqualToString:@"iPhone10,2"])   return self.deviceModel =@"iPhone 8 Plus";     // US (Verizon), China, Japan
    if ([modelIdentifier isEqualToString:@"iPhone10,3"])   return self.deviceModel =@"iPhone X";          // US (Verizon), China, Japan
    if ([modelIdentifier isEqualToString:@"iPhone10,4"])   return self.deviceModel =@"iPhone 8";          // AT&T, Global
    if ([modelIdentifier isEqualToString:@"iPhone10,5"])   return self.deviceModel =@"iPhone 8 Plus";     // AT&T, Global
    if ([modelIdentifier isEqualToString:@"iPhone10,6"])   return self.deviceModel =@"iPhone X";
    
    // iPad http://theiphonewiki.com/wiki/IPad
    
    if ([modelIdentifier isEqualToString:@"iPad1,1"])      return self.deviceModel =@"iPad 1G";
    if ([modelIdentifier isEqualToString:@"iPad2,1"])      return self.deviceModel =@"iPad 2 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad2,2"])      return self.deviceModel =@"iPad 2 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,3"])      return self.deviceModel =@"iPad 2 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPad2,4"])      return self.deviceModel =@"iPad 2 (Rev A)";
    if ([modelIdentifier isEqualToString:@"iPad3,1"])      return self.deviceModel =@"iPad 3 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad3,2"])      return self.deviceModel =@"iPad 3 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,3"])      return self.deviceModel =@"iPad 3 (Global)";
    if ([modelIdentifier isEqualToString:@"iPad3,4"])      return self.deviceModel =@"iPad 4 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad3,5"])      return self.deviceModel =@"iPad 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,6"])      return self.deviceModel =@"iPad 4 (Global)";
    
    if ([modelIdentifier isEqualToString:@"iPad4,1"])      return self.deviceModel =@"iPad Air (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad4,2"])      return self.deviceModel =@"iPad Air (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad5,3"])      return self.deviceModel =@"iPad Air 2 (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad5,4"])      return self.deviceModel =@"iPad Air 2 (Cellular)";
    
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    
    if ([modelIdentifier isEqualToString:@"iPad2,5"])      return self.deviceModel =@"iPad mini 1G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad2,6"])      return self.deviceModel =@"iPad mini 1G (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,7"])      return self.deviceModel =self.deviceModel =@"iPad mini 1G (Global)";
    if ([modelIdentifier isEqualToString:@"iPad4,4"])      return self.deviceModel =@"iPad mini 2G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad4,5"])      return self.deviceModel =@"iPad mini 2G (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad4,6"])      return self.deviceModel =@"iPad mini 2G (Cellular)"; // TD-LTE model see https://support.apple.com/en-us/HT201471#iPad-mini2
    if ([modelIdentifier isEqualToString:@"iPad4,7"])      return self.deviceModel =@"iPad mini 3G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad4,8"])      return self.deviceModel =@"iPad mini 3G (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad4,9"])      return self.deviceModel =@"iPad mini 3G (Cellular)";
    if ([modelIdentifier isEqualToString:@"iPad5,1"])      return self.deviceModel =@"iPad mini 4G (Wi-Fi)";
    if ([modelIdentifier isEqualToString:@"iPad5,2"])      return self.deviceModel =@"iPad mini 4G (Cellular)";
    
    // iPad Pro https://www.theiphonewiki.com/wiki/IPad_Pro
    
    if ([modelIdentifier isEqualToString:@"iPad6,3"])      return self.deviceModel =@"iPad Pro (9.7 inch) 1G (Wi-Fi)"; // http://pdadb.net/index.php?m=specs&id=9938&c=apple_ipad_pro_9.7-inch_a1673_wifi_32gb_apple_ipad_6,3
    if ([modelIdentifier isEqualToString:@"iPad6,4"])      return self.deviceModel =@"iPad Pro (9.7 inch) 1G (Cellular)"; // http://pdadb.net/index.php?m=specs&id=9981&c=apple_ipad_pro_9.7-inch_a1675_td-lte_32gb_apple_ipad_6,4
    if ([modelIdentifier isEqualToString:@"iPad6,7"])      return self.deviceModel =@"iPad Pro (12.9 inch) 1G (Wi-Fi)"; // http://pdadb.net/index.php?m=specs&id=8960&c=apple_ipad_pro_wifi_a1584_128gb
    if ([modelIdentifier isEqualToString:@"iPad6,8"])      return self.deviceModel =@"iPad Pro (12.9 inch) 1G (Cellular)"; // http://pdadb.net/index.php?m=specs&id=8965&c=apple_ipad_pro_td-lte_a1652_32gb_apple_ipad_6,8
    
    // iPod http://theiphonewiki.com/wiki/IPod
    
    if ([modelIdentifier isEqualToString:@"iPod1,1"])      return self.deviceModel =@"iPod touch 1G";
    if ([modelIdentifier isEqualToString:@"iPod2,1"])      return self.deviceModel =@"iPod touch 2G";
    if ([modelIdentifier isEqualToString:@"iPod3,1"])      return self.deviceModel =@"iPod touch 3G";
    if ([modelIdentifier isEqualToString:@"iPod4,1"])      return self.deviceModel =@"iPod touch 4G";
    if ([modelIdentifier isEqualToString:@"iPod5,1"])      return self.deviceModel =@"iPod touch 5G";
    if ([modelIdentifier isEqualToString:@"iPod7,1"])      return self.deviceModel =@"iPod touch 6G"; // as 6,1 was never released 7,1 is actually 6th generation
    
    // Apple TV https://www.theiphonewiki.com/wiki/Apple_TV
    
    if ([modelIdentifier isEqualToString:@"AppleTV1,1"])      return self.deviceModel =@"Apple TV 1G";
    if ([modelIdentifier isEqualToString:@"AppleTV2,1"])      return self.deviceModel =@"Apple TV 2G";
    if ([modelIdentifier isEqualToString:@"AppleTV3,1"])      return self.deviceModel =@"Apple TV 3G";
    if ([modelIdentifier isEqualToString:@"AppleTV3,2"])      return self.deviceModel =@"Apple TV 3G"; // small, incremental update over 3,1
    if ([modelIdentifier isEqualToString:@"AppleTV5,3"])      return self.deviceModel =@"Apple TV 4G"; // as 4,1 was never released, 5,1 is actually 4th generation
    
    // Simulator
    if ([modelIdentifier hasSuffix:@"86"] || [modelIdentifier isEqual:@"x86_64"])
    {
        BOOL smallerScreen = ([[UIScreen mainScreen] bounds].size.width < 768.0);
        return (smallerScreen ? (self.deviceModel = @"iPhone Simulator") : (self.deviceModel = @"iPad Simulator"));
    }
    
    return self.deviceModel = modelIdentifier;
}
@end
