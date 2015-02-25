//
//  ArtistInfoHeaderHTKCollectionReusableViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "HTKDynamicResizingCollectionViewCell.h"
#import "Artist.h"

#define DEFAULT_ARTIST_INFO_HEADER_CELL_SIZE  CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), 50)

@interface ArtistInfoHeaderHTKCollectionReusableViewCell : HTKDynamicResizingCollectionViewCell
- (void)setupCellWithArtist:(Artist *)artist;
@end
