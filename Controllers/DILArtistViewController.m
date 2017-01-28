//
//  DILArtistViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistViewController.h"
#import "DILArtistCollectionViewModel.h"
#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout.h>
#import <FlatUIKit/FlatUIKit.h>
#import "DILArtistStickyHeaderCollectionViewCell.h"
#import "SVModalWebViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DILArtistStickyHeaderCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DILArtistViewController ()<DILArtistCollectionViewModelDelegate>
@property (strong, nonatomic) UICollectionView *artistCollectionView;
@property (strong, nonatomic) DILArtistCollectionViewModel *artistCollectionViewModel;
@property (strong, nonatomic) NSString *previewUrl;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@end

BOOL musicPlaying = NO;

@implementation DILArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.previewUrl = @"";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillDisappear:(BOOL)animated
{
    musicPlaying = NO;
}

- (void)configureArtistCollectionView {
    CSStickyHeaderFlowLayout *layout = [CSStickyHeaderFlowLayout new];
    layout.minimumLineSpacing = 0;

    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 225);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), kDILArtistStickyHeaderCollectionViewSegmentedControlHeight);
        layout.parallaxHeaderAlwaysOnTop = YES;

        // If we want to disable the sticky header effect
        layout.disableStickyHeaders = YES;
    }

    self.artistCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.artistCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.artistCollectionView.alwaysBounceVertical = YES;
    self.artistCollectionView.backgroundColor = [UIColor whiteColor];
    self.artistCollectionView.showsVerticalScrollIndicator = NO;
    
    self.artistCollectionViewModel = [[DILArtistCollectionViewModel alloc] initWithArtist:self.artist];
    self.artistCollectionViewModel.delegate = self;
    self.artistCollectionViewModel.stickyHeaderCell.controller = self;

    self.artistCollectionView.dataSource = self.artistCollectionViewModel;
    self.artistCollectionView.delegate = self.artistCollectionViewModel;

    [self.view addSubview:self.artistCollectionView];
    [self.artistCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)setArtist:(DILPFArtist *)artist {
    _artist = artist;
    self.title = [artist.name uppercaseString];
    [self configureArtistCollectionView];
    self.previewUrl = [@"https://p.scdn.co/mp3-preview/" stringByAppendingString:artist.previewUrl];
    [self initTrack];
}

- (void)controlTrack:(id)sender {
    if (musicPlaying == NO) {
        musicPlaying = YES;
        [_audioPlayer play];
        [self.artistCollectionViewModel.stickyHeaderCell playMusicLabel];
    } else {
        musicPlaying = NO;
        [_audioPlayer pause];
        [self.artistCollectionViewModel.stickyHeaderCell pauseMusicLabel];
    }
}

- (void)initTrack {
    NSURL *urlStream = [[NSURL alloc] initWithString:self.previewUrl];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlStream options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:avAsset];
    _audioPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    _audioPlayer = [AVPlayer playerWithURL:urlStream];
}

- (void)reloadSection:(NSUInteger)section {
    [self.artistCollectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
}

- (void)insertItemAtIndex:(NSIndexPath *)indexPath {
    [self.artistCollectionView insertItemsAtIndexPaths:@[indexPath]];
}
@end
