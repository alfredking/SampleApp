//
//  GTSplashView.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/24.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTSplashView.h"
#import "GTScreen.h"
@interface GTSplashView()

@property(nonatomic,strong,readwrite)UIButton *button; //定义一个变量为什么要加interface呢，不加直接定义变量可以吗

@end

@implementation GTSplashView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.image = [UIImage imageNamed:@"icon.bundle/timg.jpeg"];
        [self   addSubview:({
            
            _button = [[UIButton alloc]initWithFrame:UIRect(330, 100, 60, 40)];
            _button.backgroundColor = [UIColor lightGrayColor];
            [_button setTitle:@"跳过" forState:UIControlStateNormal];
            [_button addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
            _button;
        })];
        self.userInteractionEnabled = YES; //imageview需要设置可以点击，但是点击的不是button吗
    }
    return self;
}


-(void)_removeSplashView
{
    [self removeFromSuperview];
}
@end
