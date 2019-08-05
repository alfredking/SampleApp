//
//  GTMediator.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/25.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GTDetailViewControllerProtocol <NSObject>

-(__kindof UIViewController *)initWithUrlString:(NSString *)detailUrl;

@end
@interface GTMediator : NSObject

//target action
+(__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

//url scheme
typedef void(^GTMediatorProcessBlock)(NSDictionary *params);
+(void)registerScheme: (NSString *)scheme processBlock:(GTMediatorProcessBlock)processBlock;
+(void)openUrl:(NSString *)url params:(NSDictionary *)params;

//protocol class

//为什么class不需要*
+(void)registerProtol:(Protocol *)proto class: (Class)cls;
+(Class)classForProtocol:(Protocol *)proto;
@end

NS_ASSUME_NONNULL_END
