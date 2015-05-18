//
//  DILArtistYoutubeVideoCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "DILPFYoutubeVideo.h"

@interface DILArtistYoutubeVideoCollectionViewCell : UICollectionViewCell
- (void)configureCellWithVideo:(XCDYouTubeVideo *)video __attribute__ ((deprecated));
- (void)configureCellWithDILPFYoutubeVideo:(DILPFYoutubeVideo *)video;
+ (NSString *)identifier;
@end
