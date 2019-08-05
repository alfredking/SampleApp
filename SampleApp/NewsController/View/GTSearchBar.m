//
//  GTSearchBar.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/8/4.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTSearchBar.h"
#import "GTScreen.h"
@interface GTSearchBar()<UITextFieldDelegate>

@property (nonatomic,strong, readwrite) UITextField *textField;

@end

@implementation GTSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:({
        
            _textField =[[UITextField alloc]initWithFrame:CGRectMake(UI(10), UI(5), frame.size.width- UI(10)*2,frame.size.height- UI(5)*2)];
            _textField.backgroundColor = [UIColor whiteColor];
            _textField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon.bundle/search@2x.png"]];
            _textField.leftViewMode = UITextFieldViewModeUnlessEditing;
            _textField.clearButtonMode = UITextFieldViewModeAlways;
            _textField.placeholder = @"今日热点推荐";
            _textField.delegate = self;
            _textField;
        })];
    }
    return self;
}


#pragma mark - UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSLog(@"textFieldShouldEndEditing");
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    // 字数判断
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [_textField resignFirstResponder];
    return YES;
}

@end
