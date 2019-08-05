//
//  GTVideoCoverView.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/17.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTVideoCoverView.h"
#import "GTVideoPlayer.h"
#import "GTVideoToolbar.h"
@interface GTVideoCoverView()

@property(nonatomic, strong,readwrite) UIImageView *coverView;
@property(nonatomic, strong,readwrite) UIImageView *playButton;
@property(nonatomic,copy,readwrite)NSString *videoUrl;//这里为什么要用copy  因为是要从外面传到里面 

@property(nonatomic,copy,readwrite ) GTVideoToolbar *toolbar;

@end

@implementation GTVideoCoverView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];//是不是外层 alloc init的时候调用
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height-GTVideoToolbarHeight)];
            _coverView;
        })];
        
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width -50)/2,(frame.size.height-GTVideoToolbarHeight -50)/2,50,50)];
//            _playButton.image = [UIImage imageNamed:@"icon.bundle/videoPlayer@3x.png"];
            
            _playButton;
        })];
        
        [self addSubview:({
        
            _toolbar = [[GTVideoToolbar alloc]initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolbarHeight)]; //bounds表示什么意思，这个bounds不应该是在layer之上的吗
            
            _toolbar;
        })];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
        
        
    }
    return self;
}

-(void)dealloc
{
    
    
    
}
#pragma mark public method
-(void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl
{
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
    //videoUrl = videoUrl; 为什么这一行不行
    _videoUrl = videoUrl;
    
    [_toolbar layoutWithMode:nil];
}


-(void)_tapToPlay
{
    
    [[GTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
}

@end
