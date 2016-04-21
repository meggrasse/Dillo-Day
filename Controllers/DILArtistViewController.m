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
//@property (strong, nonatomic) NSString *previewUrl;
//@property (strong, nonatomic) AVPlayer *audioPlayer;
@end

//BOOL musicPlaying = NO;

@implementation DILArtistViewController

//@synthesize ref= _ref;
//@synthesize headerView;

- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.previewUrl = @"";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _headerView = [DILArtistStickyHeaderCollectionViewCell alloc];
//    [headerView.circularImageView addTarget:self action:@selector(controlTrack:) forControlEvents:UIControlEventTouchUpInside];
//    [headerView.circularImageView addTarget:headerView action:@selector(controlTrack:) forControlEvents:UIControlEventTouchUpInside];
//    [self initTrack];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"bye");
    // [super viewWillDisappear:animated];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    if ([touch view] == _headerView.circularImageView) {
//        NSLog(@"touch");
//    }
//    else if ([touch view] == _headerView.backgroundImageView) {
//        NSLog(@"other touch");
//    }
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

    self.artistCollectionView.dataSource = self.artistCollectionViewModel;
    self.artistCollectionView.delegate = self.artistCollectionViewModel;

    [self.view addSubview:self.artistCollectionView];
    [self.artistCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)setArtist:(DILPFArtist *)artist {
    _artist = artist;
    self.title = [artist.name uppercaseString];
    [self configureArtistCollectionView];
//    self.previewUrl = [@"https://p.scdn.co/mp3-preview/" stringByAppendingString:artist.previewUrl];
}

- (void)controlTrack:(id)sender {
    NSLog(@"check");
//    if (musicPlaying == NO) {
//        musicPlaying = YES;
//        [_audioPlayer play];
//        self.ref.circleLabel.text = @"   \u258D\u258D";
//        self.ref.circleLabel.font = [UIFont systemFontOfSize:35];
//        self.ref.circleLabel.textAlignment = NSTextAlignmentRight;
//    } else {
//        musicPlaying = NO;
//        [_audioPlayer pause];
//        self.ref.circleLabel.text = @"\u25B6";
//        self.ref.circleLabel.textAlignment = NSTextAlignmentRight;
//        self.ref.circleLabel.font = [UIFont systemFontOfSize:80];
//    }
}

//- (void)initTrack {
//    NSURL *urlStream = [[NSURL alloc] initWithString:self.previewUrl];
//    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlStream options:nil];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:avAsset];
//    _audioPlayer = [AVPlayer playerWithPlayerItem:playerItem];
//    _audioPlayer = [AVPlayer playerWithURL:urlStream];
//    [_headerView.circularImageView addTarget:_headerView.circularImageView action:@selector(controlTrack:) forControlEvents:UIControlEventTouchUpInside];
   // [self.ref.circularImageView addTarget:_ref action:@selector(controlTrack:) forControlEvents:UIControlEventTouchUpInside];
   // [self.ref.circularImageView addTarget:self.ref.circularImageView action:@selector(controlTrack:) forControlEvents:UIControlEventTouchUpInside];
//}

- (void)reloadSection:(NSUInteger)section {
    [self.artistCollectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
//    [self.artistCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)insertItemAtIndex:(NSIndexPath *)indexPath {
    [self.artistCollectionView insertItemsAtIndexPaths:@[indexPath]];
}
@end
