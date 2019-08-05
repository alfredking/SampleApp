//
//  GTDetailViewController.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/6/22.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTDetailViewController.h"
#import <WebKit/WebKit.h>
#import "GTScreen.h"
#import "GTMediator.h"
#import "GTLogin.h"
@interface GTDetailViewController () <WKNavigationDelegate>
@property (nonatomic,strong , readwrite)WKWebView *webview;
@property(nonatomic,strong,readwrite) UIProgressView *progressview;
@property(nonatomic,copy,readwrite) NSString *articleUrl; //这里的属性为什么是copy

@end

@implementation GTDetailViewController
//类装载的时候会调用load函数
+(void)load
{
    //url scheme 方法
//    [GTMediator registerScheme: @"detail://" processBlock:^(NSDictionary * _Nonnull params) {
//        NSString *url =[params objectForKey:@"url"];
//        UINavigationController *navigationController = [params objectForKey:@"controller"];
//        GTDetailViewController *controller = [[GTDetailViewController alloc]initWithUrlString:url];
//
//        //controller.title = [NSString stringWithFormat:@"%@",@(indexPath.row)];
//
//        [navigationController pushViewController:controller animated:YES];
//    }];
    
    [GTMediator registerProtol:@protocol(GTDetailViewControllerProtocol) class:[self class]];
    
}
-(void)dealloc
{
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
}

//-(__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl
//{
//    [self initWithUrlString:detailUrl];
//}
-(instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        self.articleUrl = urlString;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(_shareArticle)];
    [self.view addSubview:({
        self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, STATUSBARHEIGHT+44, self.view.frame.size.width, self.view.frame.size.height-STATUSBARHEIGHT-44)];
        self.webview.navigationDelegate = self;
        self.webview;
        
     
    })];
    
    [self.view addSubview:({
        self.progressview = [[UIProgressView alloc ]initWithFrame:CGRectMake(0, STATUSBARHEIGHT+44, self.view.frame.size.width, 20)];
        self.progressview;
    })];
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]]];
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];//context是其他参数
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didFinishNavigation");
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context
{
    NSLog(@"observeValueForKeyPath");
    self.progressview.progress =self.webview.estimatedProgress;
}

-(void)_shareArticle
{
    [[GTLogin sharedLogin]shareToQQWithArticleUrl:[NSURL URLWithString:self.articleUrl]];
}


@end
