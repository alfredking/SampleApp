//
//  GTNormalTableViewCell.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/5/17.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTNormalTableViewCell.h"
#import "GTListItem.h"
#import "SDWebImage.h"
#import "GTScreen.h"

@interface GTNormalTableViewCell ()
@property(nonatomic,strong,readwrite) UILabel *titleLabel;
@property(nonatomic,strong,readwrite) UILabel *sourceLabel;
@property(nonatomic,strong,readwrite) UILabel *commentLabel;
@property(nonatomic,strong,readwrite) UILabel *timeLabel;

@property (nonatomic,strong,readwrite) UIImageView *rightImageView;
@property (nonatomic,strong,readwrite) UIButton *deleteButton;


@end
@implementation GTNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc]initWithFrame:UIRect(20,15,270,50)];
//            self.titleLabel.backgroundColor = [UIColor redColor];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc]initWithFrame:UIRect(20,70,50,20)];
//            self.sourceLabel.backgroundColor = [UIColor redColor];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel;
        })];
        
        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc]initWithFrame:UIRect(100,70,50,20)];
//            self.commentLabel.backgroundColor = [UIColor redColor];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];
        
        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc]initWithFrame:UIRect(150,70,50,20)];
//            self.timeLabel.backgroundColor = [UIColor redColor];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];
        
        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc]initWithFrame:UIRect(300,15,100,70)];
            //self.rightImageView.backgroundColor = [UIColor redColor];
            self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.rightImageView;
        })];
        
        
//        [self.contentView addSubview:({
//            self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(290,80,30,20)];
//            [self.deleteButton setTitle:@"x" forState:UIControlStateNormal];
//            [self.deleteButton setTitle:@"v" forState:UIControlStateHighlighted];
//            //self.deleteButton.backgroundColor = [UIColor blueColor];
//
//            self.deleteButton.layer.cornerRadius = 10;
//            self.deleteButton.layer.masksToBounds = YES;
//
//            self.deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//            self.deleteButton.layer.borderWidth = 2;
//
//            self.deleteButton;
//        })];
//
//        [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)layoutTabelViewCellWithItem : (GTListItem *)item
{
//    self.titleLabel.text = @"极客时间iOS开发"; //设置行间距等需要使用NSAtrributestring
//
//    self.sourceLabel.text = @"极客时间";
//    [self.sourceLabel sizeToFit];
//
//    self.commentLabel.text = @"1888评论";
//    [self.commentLabel sizeToFit];
//    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x+self.sourceLabel.frame.size.width+15
//                                         , self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
//
//    self.timeLabel.text = @"三分钟前";
//    [self.timeLabel sizeToFit];
//    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x+self.commentLabel.frame.size.width+15
//                                         , self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
//
//    self.rightImageView.image = [UIImage imageNamed:@"icon.bundle/timg.jpeg"];
    
    BOOL hasRead = [[NSUserDefaults standardUserDefaults]boolForKey:item.uniqueKey];
    if (hasRead) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }
    else
    {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
        self.titleLabel.text = item.title; //设置行间距等需要使用NSAtrributestring
    
        self.sourceLabel.text = item.authorName;
        [self.sourceLabel sizeToFit];
    
        self.commentLabel.text = item.category;
        [self.commentLabel sizeToFit];
        self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x+self.sourceLabel.frame.size.width+UI(15)
                                             , self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
    
        self.timeLabel.text = item.date;
        [self.timeLabel sizeToFit];
        self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x+self.commentLabel.frame.size.width+UI(15)
                                             , self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    
//    NSThread *downloadImageThread = [[NSThread alloc]initWithBlock:^{
//        UIImage *image= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];  //  耗时操作不应该放在主线程
//        self.rightImageView.image = image;
//
//    }];
//    downloadImageThread.name = @"downloadImageThread";
//    [downloadImageThread start];
    
    
    //为什么此处的queue不需要加*号
//    dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
//
//    dispatch_async(downloadQueue, ^{
//        UIImage *image= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//        dispatch_async(mainQueue, ^{
//            self.rightImageView.image = image;
//        });
//    });
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"sd_setImageWithURL");
    }];
    
    
}

-(void)deleteButtonClick
{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableviewCell:clickDeleteButton:)]) {
        [self.delegate tableviewCell:self clickDeleteButton:self.deleteButton];
    }
    NSLog(@"deleButtonClick");
    
}
@end
