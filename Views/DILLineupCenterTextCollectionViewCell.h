//
//  DILLineupCenterTextCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFArtist.h"

@interface DILLineupCenterTextCollectionViewCell : UICollectionViewCell
- (void)configureCellWithArtist:(DILPFArtist *)artist;
@end
