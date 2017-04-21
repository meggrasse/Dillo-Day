//
//  DILLineupCellViewController.h
//  Dillo Day
//
//  Created by Meg Grasse on 4/19/17.
//  Copyright © 2017 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DILPFArtist.h"
#import "YTPlayerView.h"

@interface DILLineupCellViewController : UIViewController<YTPlayerViewDelegate>

- (void)setupYTPlayerView:(CGRect)frame forArtist:(DILPFArtist *)artist;

@end
