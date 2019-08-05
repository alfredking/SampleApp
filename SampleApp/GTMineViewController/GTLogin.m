//
//  GTLogin.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/26.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTLogin.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface  GTLogin()<TencentSessionDelegate>

@property (nonatomic,strong,readwrite) TencentOAuth *oauth;
@property (nonatomic,copy,readwrite) GTLoginFinishBlock finishBlock; //block传递是复制一份

@property (nonatomic,assign,readwrite) BOOL isLogin; //这里为什么又要用assign,基本数据类型都是用assign修饰

//放在这里就是内部使用，放在.h就是给外部使用
//@property (nonatomic,strong,readwrite) NSString *avatarUrl;
//@property (nonatomic,strong,readwrite) NSString *nick;
//@property (nonatomic,strong,readwrite) NSString *address;

@end

@implementation GTLogin

//+(instancetype)sharedLogin
//{
//    self = [super init];
//    if (self) {
//        NSLog(@"");
//    }
//    return self;
//    
//}

+(instancetype)sharedLogin
{
    static GTLogin *login;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[GTLogin alloc]init];
    });
    return login; //这个初始化方法只是保证了单例，没有其他的具体逻辑
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _isLogin = NO;
        _oauth = [[TencentOAuth alloc]initWithAppId:@"222222" andDelegate:self];
    }
    return self;
}
-(BOOL)isLogin
{
    //登录失效的逻辑
    return _isLogin;
}

-(void)loginWithFinishBlock:(GTLoginFinishBlock)finishBlock
{
    _finishBlock = [finishBlock copy];
    _oauth.authMode = kAuthModeClientSideToken;
    [_oauth authorize:@[kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,kOPEN_PERMISSION_ADD_ALBUM,kOPEN_PERMISSION_ADD_ONE_BLOG]];
}

-(void)logOut
{
    [_oauth logout:self];
    _isLogin = NO;
}


#pragma mark -delegate

-(void)tencentDidLogin
{
    _isLogin = YES;
    [_oauth getUserInfo];
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (_finishBlock) {
        _finishBlock(NO);
    }
}

-(void)tencentDidNotNetWork
{
    
}

-(void)tencentDidLogout
{
    
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    NSDictionary *userinfo = response.jsonResponse;
    _nick = userinfo[@"nickname"];
    _address = userinfo[@"city"];
    _avatarUrl=userinfo[@"figureurl_qq_2"];
    if (_finishBlock) {
        _finishBlock(YES);
    }
}


-(void)shareToQQWithArticleUrl:(NSURL *)articleUrl
{
    //登录校验
    //loginWithFinishBlock
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:articleUrl title:@"ios" description:@"从0开始iOS开发" previewImageURL:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    
}
@end
