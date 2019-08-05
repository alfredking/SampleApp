//
//  GTVideoCoverView.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/17.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN //非空开始是什么意思

@interface GTVideoCoverView : UICollectionViewCell

-(void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;
@end

NS_ASSUME_NONNULL_END
