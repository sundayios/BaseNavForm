#import "FB_AppDelegate.h"
#import "FB_SplashViewController.h"

#import "AppDelegate+Configuration.h"
#import "AppDelegate+NetworkObserver.h"

@interface FB_AppDelegate ()

@end
@implementation FB_AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.FB_P_isFirstLoad = YES;
    
    [self FB_M_startNetworkObserve];
    
    FB_SplashViewController *splashVC = [[FB_SplashViewController alloc]init];
    self.window.rootViewController = splashVC;
    
    return YES;
    
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
@end
