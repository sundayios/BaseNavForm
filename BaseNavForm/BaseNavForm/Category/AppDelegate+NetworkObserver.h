//
//  AppDelegate+NetworkObserver.h
//  NewsIntegrated01
//
//  Created by lianpu3 on 2018/7/20.
//  Copyright © 2018年 IMAC. All rights reserved.
//

#import "FB_AppDelegate.h"

@interface FB_AppDelegate (NetworkObserver)

@property (nonatomic,assign) AFNetworkReachabilityStatus FB_P_networkStatus;

@property (nonatomic,assign) BOOL FB_P_isFirstLoad;
- (void)FB_M_startNetworkObserve;
@end
