//
//  GTListLoader.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/6/29.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTListItem;
typedef void(^GTListLoaderFinishBlock)(BOOL success,NSArray<GTListItem *> *dataArray);

NS_ASSUME_NONNULL_BEGIN


/**
 列表请求
 */
@interface GTListLoader : NSObject

-(void)loadListDataWithFinishBlock: (GTListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
