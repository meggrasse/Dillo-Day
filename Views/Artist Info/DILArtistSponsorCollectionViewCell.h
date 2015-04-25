//
//  DILArtistSponsorCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/24/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFSponsor.h"
@interface DILArtistSponsorCollectionViewCell : UICollectionViewCell
- (void)configureCellWithSponsor:(DILPFSponsor *)sponsor;
+ (NSString *)identifier;
@end
