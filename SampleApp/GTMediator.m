//
//  GTMediator.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/25.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTMediator.h"
@implementation GTMediator


+(__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl
{
//    //这种方法耦合性还是太强
//    GTDetailViewController *controller = [[GTDetailViewController alloc]initWithUrlString: detailUrl];
    
    Class  detailCls = NSClassFromString(@"GTDetailViewController");
    
    UIViewController *controller = [[detailCls alloc] performSelector:NSSelectorFromString(@"initWithUrlString:") withObject:detailUrl ]; //最多能传递两个参数，使用场景受限，不过可以传字典
    
    return controller;
}

#pragma mark -

+(NSMutableDictionary *)mediatorCache
{
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}
+(void)registerScheme: (NSString *)scheme processBlock:(GTMediatorProcessBlock)processBlock
{
    if (scheme&&processBlock)
    {
        [[[self class]mediatorCache] setObject:processBlock forKey:scheme];
    }
}

+(void)openUrl:(NSString *)url params:(NSDictionary *)params
{
    GTMediatorProcessBlock block = [[[self class]mediatorCache]objectForKey:url];
    if (block) {
        block(params);
    }
}

+(void)registerProtol:(Protocol *)proto class: (Class)cls
{
    if (proto&&cls)
    {
        [[[self class] mediatorCache]setObject:cls forKey:NSStringFromProtocol(proto)];
    }
}

+(Class)classForProtocol:(Protocol *)proto
{
    return [[[self class]mediatorCache]objectForKey:NSStringFromProtocol(proto)];
}

@end
