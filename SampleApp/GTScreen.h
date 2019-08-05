//
//  GTScreen.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/24.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define UI(x) UIAdapter(x)
#define UIRect(x,y,width,height) UIRectAdapter(x,y,width,height)

#define IS_IPHONE_X (SCREEN_WIDTH == [GTScreen sizeFor58Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor58Inch].height)

#define IS_IPHONE_XR (SCREEN_WIDTH == [GTScreen sizeFor6Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor6Inch].height&& [UIScreen mainScreen].scale == 2)

#define IS_IPHONE_XMAX (SCREEN_WIDTH == [GTScreen sizeFor65Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X||IS_IPHONE_XR||IS_IPHONE_XMAX)

#define STATUSBARHEIGHT (IS_IPHONE_X_XR_MAX ? 44 :20)
static inline NSInteger  UIAdapter(float x)
{
    //1 - 分机型 特定比例
    
    //2 - 屏幕宽度按比例适配
    CGFloat scale = 414/SCREEN_WIDTH;
    
    return (NSInteger)x/scale;
}

static inline CGRect UIRectAdapter(x,y,width,height)
{
    return CGRectMake(UIAdapter(x),UIAdapter(y),UIAdapter(width),UIAdapter(height));
}

@interface GTScreen : NSObject

//iphone xs max
+(CGSize)sizeFor65Inch;

//iphone xr
+(CGSize)sizeFor6Inch;

//iphonex
+(CGSize)sizeFor58Inch;

@end

NS_ASSUME_NONNULL_END
