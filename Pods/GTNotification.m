//
//  GTNotification.m
//  AFNetworking
//
//  Created by alfredking－cmcc on 2019/8/3.
//

#import "GTNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface GTNotification() <UNUserNotificationCenterDelegate>//头文件和实现文件里面都有interface是为什么

@end

@implementation GTNotification

+(GTNotification *)notificationManager
{
    static GTNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GTNotification alloc] init];
    });
    
    return manager;
}

-(void)checkNotificationAuthorization
{
    UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"checkNotificationAuthorization ");
        if(granted)
        {
            //本地通知
           // [self _pushLocalNotification];
            //既然是要在主线程完成，为什么需要asyn
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications]; //UIApplication需要uikit的支持
            });
        }
        
    }];
}

-(void)_pushLocalNotification
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.badge=@(1);
    content.title=@"极客时间";
    content.body=@"从0开发一款ios app";
    content.sound=[UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger= [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.f repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest  requestWithIdentifier:@"_pushLocalNotification" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"_pushLocalNotification");
    }];
    
}

#pragma mark - 通知代理方法

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog(@"willPresentNotification");
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler
{
    //处理业务逻辑
    completionHandler();
}
@end
