//
//  DILArtistViewController.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFArtist.h"
#import "DILArtistStickyHeaderCollectionViewCell.h"

@class DILArtistStickyHeaderCollectionViewCell;
@interface DILArtistViewController : UIViewController
@property (strong, nonatomic) DILPFArtist *artist;
@property (strong, nonatomic) DILArtistStickyHeaderCollectionViewCell *headerView;
- (void)controlTrack:(id)sender;
@end
