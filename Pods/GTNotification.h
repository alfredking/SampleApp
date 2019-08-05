//
//  GTNotification.h
//  AFNetworking
//
//  Created by alfredking－cmcc on 2019/8/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 APP推送管理
 */
@interface GTNotification : NSObject

+(GTNotification *)notificationManager;

-(void)checkNotificationAuthorization;
@end

NS_ASSUME_NONNULL_END
