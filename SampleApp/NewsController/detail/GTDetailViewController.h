//
//  GTDetailViewController.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/6/22.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMediator.h"

NS_ASSUME_NONNULL_BEGIN


/**
 文章底层页面
 */
@interface GTDetailViewController : UIViewController<GTDetailViewControllerProtocol>

-(instancetype)initWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
