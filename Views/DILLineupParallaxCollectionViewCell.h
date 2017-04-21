//
//  DILLineupParallaxCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFArtist.h"
#import "FMEParallaxPFImageView.h"

@interface DILLineupParallaxCollectionViewCell : UICollectionViewCell

- (void)configureCellWithArtist:(DILPFArtist *)artist scrollView:(UIScrollView *)scrollView;
- (void)announcementLabelAnimation;
+ (NSString *)identifier;

@end
