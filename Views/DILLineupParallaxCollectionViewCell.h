//
//  DILLineupParallaxCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFArtist.h"

@interface DILLineupParallaxCollectionViewCell : UICollectionViewCell
- (void)configureCellWithArtist:(DILPFArtist *)artist scrollView:(UIScrollView *)scrollView;
+ (NSString *)identifier;
@end
