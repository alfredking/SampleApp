//
//  GTCommentManager.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/8/4.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTCommentManager : NSObject

+(GTCommentManager *)sharedManager;

-(void)showCommentView;

@end

NS_ASSUME_NONNULL_END
