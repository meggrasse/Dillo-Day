//
//  ArtistInfoAlwaysOnTopHeaderCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

@interface ArtistInfoAlwaysOnTopHeaderCollectionViewCell : UICollectionViewCell
- (void)setupCellWithArtist:(Artist *)artist;
@end
