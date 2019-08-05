//
//  GTCommentManager.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/8/4.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTCommentManager.h"
#import "GTScreen.h"
@interface GTCommentManager()<UITextViewDelegate>

@property(nonatomic,strong,readwrite)UIView *backgroundView;
@property(nonatomic,strong,readwrite)UITextView *textView;

@end

@implementation GTCommentManager

+(GTCommentManager *)sharedManager
{
    static GTCommentManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GTCommentManager alloc]init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapBackground)]];
        
        // 初始的时候在屏幕之下
        [_backgroundView addSubview:({
            _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, _backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100))];
            _textView.backgroundColor = [UIColor whiteColor];
            _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _textView.layer.borderWidth = 5.f;
            _textView.delegate = self;
            _textView;
        })];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_doTextViewAnimationWithNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

-(void)showCommentView
{
    [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
    
    [_textView becomeFirstResponder];
}

#pragma mark -

-(void)_tapBackground
{
    [_textView resignFirstResponder];
    [_backgroundView removeFromSuperview];
}


-(void) _doTextViewAnimationWithNotification:(NSNotification *)noti
{
    NSLog(@"");
    CGFloat duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyboardFrame.origin.y>= SCREEN_HEIGHT)
    {
        //键盘收起 仍然隐藏在屏幕下方
        [UIView animateWithDuration:duration animations:^{
            self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100));
        }];
    }
    else
    {
        //键盘升起
        self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100));
        [UIView animateWithDuration:duration animations:^{
            self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height-keyboardFrame.size.height-UI(100), SCREEN_WIDTH, UI(100));
        }];
    }
}

#pragma mark -
//delegate 控制字符最大长度等
@end