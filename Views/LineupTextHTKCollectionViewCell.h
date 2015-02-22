//
//  LineupTextHTKCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/20/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "HTKDynamicResizingCollectionViewCell.h"

#define DEFAULT_LINEUP_TEXT_CELL_SIZE  CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), 50)

@interface LineupTextHTKCollectionViewCell : HTKDynamicResizingCollectionViewCell
- (void)setupCellWithArtist:(NSString *)artist atTime:(NSString *)time;
@end
