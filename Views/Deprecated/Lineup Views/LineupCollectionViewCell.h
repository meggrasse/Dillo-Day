//
//  LineupCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

#define IMAGE_OFFSET_SPEED 15

@interface LineupCollectionViewCell : UICollectionViewCell
- (void)setupCellWithArtist:(Artist *)artist;

@property (nonatomic, assign, readwrite) CGPoint imageOffset;
@property (nonatomic, readonly) CGFloat imageViewHeight;
@end
