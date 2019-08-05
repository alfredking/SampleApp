//
//  GTNormalTableViewCell.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/5/17.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GTListItem;


/**
 点击删除按钮
 */
@protocol GTNormalTableViewCellDelegate <NSObject>

-(void)tableviewCell: (UITableViewCell *)tableViewCell clickDeleteButton : (UIButton *)deleteButton;

@end



/**
 新闻列表cell
 */
@interface GTNormalTableViewCell : UITableViewCell

@property(nonatomic ,weak,readwrite) id<GTNormalTableViewCellDelegate> delegate;
-(void)layoutTabelViewCellWithItem : (GTListItem *)item;
@end

NS_ASSUME_NONNULL_END
