//
//  GTLocation.h
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/7/27.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 app中统一的位置信息管理
 */
@interface GTLocation : NSObject

+(GTLocation *)locationManager;
-(void)checkLocationAuthorization;

@end

NS_ASSUME_NONNULL_END
