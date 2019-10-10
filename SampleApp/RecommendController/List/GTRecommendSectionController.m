//
//  GTRecommendSectionController.m
//  SampleApp
//
//  Created by alfredking－cmcc on 2019/8/7.
//  Copyright © 2019 alfredking. All rights reserved.
//

#import "GTRecommendSectionController.h"
#import "GTScreen.h"
#import "GTRecommendCell.h"

@interface GTRecommendSectionController ()

@end

@implementation GTRecommendSectionController


-(NSInteger)numberOfItems
{
    return 2;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index
{
    return CGSizeMake(SCREEN_WIDTH, UI(60));
}

-(__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    return [self.collectionContext  dequeueReusableCellOfClass:[GTRecommendCell class] forSectionController:self atIndex:index];
}

@end
