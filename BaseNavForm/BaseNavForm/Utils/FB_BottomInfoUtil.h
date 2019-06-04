//
//  FB_BottomInfoUtil.h
//  WangCai
//
//  Created by zcx on 2018/7/5.
//  Copyright © 2018年 szFacebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FB_barItem;
@interface FB_BottomInfoUtil : NSObject

+ (FB_BottomInfoUtil *)shareSingleTon;


+ (NSURLSessionTask *)fetchBottomBarIconSuccess:(void(^)())success;

@end

@interface FB_barItem : NSObject

@property (nonatomic, copy)NSString *barItemNormalImageUrl;
@property (nonatomic, copy)NSString *barItemHighlightImageUrl;
@property (nonatomic, copy)NSString *barItemTitle;
@property (nonatomic, copy)NSString *barItemIndex;
@property (nonatomic, copy)NSString *disableMsg;
@property (nonatomic, copy)NSString *enable;

@end
