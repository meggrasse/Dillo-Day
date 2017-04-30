//
//  DILLineupCellViewController.h
//  Dillo Day
//
//  Created by Meg Grasse on 4/19/17.
//  Copyright © 2017 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DILPFArtist.h"
#import "DILLineupParallaxCollectionViewCell.h"
#import "YTPlayerView.h"

@interface DILLineupCellViewController : UIViewController<YTPlayerViewDelegate>

@property (strong, nonatomic) DILLineupParallaxCollectionViewCell *cell;

- (void)setupYTPlayerViewForCell:(DILLineupParallaxCollectionViewCell *)cell forArtist:(DILPFArtist *)artist;
- (void)removeVideo;

@end
