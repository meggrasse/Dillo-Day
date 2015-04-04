//
//  DILArtistYoutubeVideoCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>

@interface DILArtistYoutubeVideoCollectionViewCell : UICollectionViewCell
- (void)configureCellWithVideo:(XCDYouTubeVideo *)video;
+ (NSString *)identifier;
@end
