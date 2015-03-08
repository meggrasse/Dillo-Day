//
//  ArtistInfoVideoHTKCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/25/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

@interface ArtistInfoVideoCollectionViewCell : UICollectionViewCell
- (void)setupCellWithVideo:(XCDYouTubeVideo *)video;
@end
