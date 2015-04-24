//
//  DILLineupCenterTextCollectionViewCellRadialShadowView.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/23/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupCenterTextCollectionViewCellRadialShadowView.h"

@implementation DILLineupCenterTextCollectionViewCellRadialShadowView

- (void)drawRect:(CGRect)rect {
    [DilloDayStyleKit drawLineupCellRadialFadeWithCellFrame:rect];
}

@end
