//
//  GTLogin.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/26.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GTLoginFinishBlock)(BOOL isLogin);

NS_ASSUME_NONNULL_BEGIN

@interface GTLogin : NSObject

+(instancetype)sharedLogin;

@property (nonatomic,strong,readwrite) NSString *avatarUrl;
@property (nonatomic,strong,readwrite) NSString *nick;
@property (nonatomic,strong,readwrite) NSString *address;


#pragma mark -登录
-(BOOL)isLogin;
-(void)loginWithFinishBlock:(GTLoginFinishBlock)finishBlock;
-(void)logOut;

#pragma mark -分享
-(void)shareToQQWithArticleUrl:(NSURL *)articleUrl;
@end

NS_ASSUME_NONNULL_END
