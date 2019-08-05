//
//  TodayViewController.m
//  GTToday
//
//  Created by alfredking－cmcc on 2019/8/3.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <TencentOpenAPI/QQApiInterface.h>
@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:({
    
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 200, 100)];
        [button setTitle:@"点击跳转" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_openSampleApp) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
    
    NSUserDefaults *userDefault= [[NSUserDefaults alloc]initWithSuiteName:@"group.com.cmcc.sample"];
    
    [userDefault objectForKey: @"title"];
    NSLog(@"");
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}


#pragma mark _
-(void)_openSampleApp
{
    [self.extensionContext openURL:[NSURL URLWithString:@"tencent222222://"] completionHandler:^(BOOL success) {
        NSLog(@"");
    }];
}
@end
