//
//  DILArtistBioHTKCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/3/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "HTKDynamicResizingCollectionViewCell.h"
#import "DILPFArtist.h"

@interface DILArtistBioHTKCollectionViewCell : HTKDynamicResizingCollectionViewCell
- (void)configureCellWithArtist:(DILPFArtist *)artist;
+ (CGSize)defaultSize;
+ (NSString *)identifier;
@end
