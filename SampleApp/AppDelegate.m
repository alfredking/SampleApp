//
//  AppDelegate.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/4/27.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "AppDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "GTRecommandViewController.h"
#import "GTSplashView.h"
#import "GTStaticTest.h"
#import "GTMineViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <GTFramework/GTFrameworkTest.h>
#include <execinfo.h>
#import "GTLocation.h"
#import "GTNotification.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    UITabBarController *tabbarController = [[UITabBarController alloc]init];
    
    GTNewsViewController *newsViewController = [[GTNewsViewController alloc] init];
    
    
    
    
    
    
//    UIViewController *controller1 =[[UIViewController alloc]init];
//    controller1.view.backgroundColor = [UIColor redColor];
    newsViewController.tabBarItem.title = @"新闻";
    newsViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
    newsViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    
    GTVideoViewController *videoController =[[GTVideoViewController alloc]init];
    GTRecommandViewController *recommandController = [[GTRecommandViewController alloc]init];
    
    
    GTMineViewController *mineViewController =[[GTMineViewController alloc]init];
    
    [tabbarController setViewControllers:@[newsViewController,videoController,recommandController,mineViewController]];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:tabbarController];
    tabbarController.delegate = self;
    self.window.rootViewController =navigationController;
    [self.window makeKeyAndVisible];
    
    [self.window addSubview:({
        GTSplashView *splashView= [[GTSplashView alloc]initWithFrame:self.window.bounds];
        splashView;
    })];
    
    //static
   // [[GTStaticTest alloc]init];
    
    //framework
    //[[GTFrameworkTest alloc]init];
//    [self _caughtException];
//    [@[].mutableCopy addObject:nil];
    [[GTLocation locationManager] checkLocationAuthorization];
    [[GTNotification notificationManager]  checkNotificationAuthorization];
    //隐藏通知数字
    //[UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    NSUserDefaults *userDefault= [[NSUserDefaults alloc]initWithSuiteName:@"group.com.cmcc.sample"];
    
    [userDefault setObject:@"从0开发一款iOS app" forKey:@"title"];
    
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    NSLog(@"did select");
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -  注册通知

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}
#pragma mark

-(BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [TencentOAuth HandleOpenURL:url];

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}



#pragma mark -crash

-(void)_caughtException
{
    //nsexception
    NSSetUncaughtExceptionHandler(HandleNSException);
    
    //signal
    signal(SIGABRT, SignalExceptionHandler); //注册需要监听的信号量，传入处理函数
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGABRT, SignalExceptionHandler);
}

void SignalExceptionHandler(int signal)
{
    void* callstack[128];
    int frames = backtrace(callstack,128);
    char **strs = backtrace_symbols(callstack,frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i =0; i<frames; i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
}

void HandleNSException(NSException *exception)
{
    __unused NSString *reason  =[exception reason];
    __unused NSString *name  =[exception name];
    
    //存储crash信息
}


#pragma mark -动态切换图标

-(void)_changeIcon
{
    if ([UIApplication sharedApplication].supportsAlternateIcons)
    {
        [[UIApplication sharedApplication] setAlternateIconName:@"test" completionHandler:^(NSError * _Nullable error) {
            NSLog(@"");
        }];
    }
}
@end
