//
//  DILLineupCellViewController.m
//  Dillo Day
//
//  Created by Meg Grasse on 4/19/17.
//  Copyright © 2017 Mayfest. All rights reserved.
//

#import "DILLineupCellViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface DILLineupCellViewController ()

@property (strong, nonatomic) YTPlayerView *playerView;
@property (strong, nonatomic) DILLineupParallaxCollectionViewCell *cell;
@property (strong, nonatomic) DILPFArtist *artist;

@end

@implementation DILLineupCellViewController

- (void)viewDidLoad {
    self.playerView.delegate = self;

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.playerView removeFromSuperview];
}

- (void)setupYTPlayerViewForCell:(DILLineupParallaxCollectionViewCell *)cell forArtist:(DILPFArtist *)artist {

    self.artist = artist;
    self.cell = cell;
    CGRect frame = cell.bounds;
    
    //math to get rid of Youtube black bars
    CGFloat newWidth = (1280.0/960.0*frame.size.width);
    CGFloat newHeight = (9.0/16.0)*newWidth;
    CGFloat newX = frame.origin.x - (newWidth - frame.size.width)/2;
    CGFloat newY = frame.origin.y - (newHeight - frame.size.height)/2;

    CGRect newFrame = CGRectMake(newX, newY, newWidth, newHeight);

    self.playerView = [[YTPlayerView alloc] initWithFrame: newFrame];
    [self.view addSubview:self.playerView];

    NSDictionary *playerVars = @{
                                 @"controls" : @0,
                                 @"loop" : @1,
                                 @"modestbranding" : @0,
                                 @"playsinline" : @1,
                                 @"showinfo" : @0,
                                 @"rel" : @0
                                 };

    [self.playerView loadWithVideoId:artist.announcementVideoId playerVars:playerVars];
}

- (void)removeVideo {
    [self.playerView stopVideo];
    [self.playerView removeFromSuperview];
}

# pragma mark - YTPlayerViewDelegate methods
- (void)playerViewDidBecomeReady:(YTPlayerView* )playerView {
    [self.playerView playVideo];
    [self.cell announcementLabelAnimation:self.artist];
}

@end
