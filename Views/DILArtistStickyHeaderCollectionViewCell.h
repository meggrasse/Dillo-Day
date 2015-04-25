//
//  DILArtistStickyHeaderCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFArtist.h"
#import "DILArtistCollectionViewModel.h"

static CGFloat const kDILArtistStickyHeaderCollectionViewSegmentedControlHeight = 50.0;

@protocol DILArtistStickyHeaderCollectionViewCellDelegate <NSObject>
@required
- (void)displayArtistInfoType:(DILArtistInfoType)type;
@end

@interface DILArtistStickyHeaderCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) id<DILArtistStickyHeaderCollectionViewCellDelegate> delegate;
- (void)configureCellWithArtist:(DILPFArtist *)artist;
+ (NSString *)identifier;
@end
