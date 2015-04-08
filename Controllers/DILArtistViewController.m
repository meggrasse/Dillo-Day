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

@interface DILArtistViewController ()<DILArtistCollectionViewModelDelegate>
@property (strong, nonatomic) UICollectionView *artistCollectionView;
@property (strong, nonatomic) DILArtistCollectionViewModel *artistCollectionViewModel;
@property (strong, nonatomic) UIBarButtonItem *artistAlertsBarButton;
@end

@implementation DILArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureArtistAlertBarButtonItem];
}

- (void)configureArtistAlertBarButtonItem {
    self.artistAlertsBarButton = [[UIBarButtonItem alloc] initWithImage:[self artistAlertsImage] style:UIBarButtonItemStylePlain target:self action:@selector(handleArtistAlertsTap)];
    self.navigationItem.rightBarButtonItem = self.artistAlertsBarButton;
}

- (UIImage *)artistAlertsImage {
    UIImage *image;

    if (self.artist.artistAlerts) {
        image = [UIImage imageNamed:@"check with circle"];
    } else {
        image = [UIImage imageNamed:@"Add with circle"];
    }
    return image;
}

- (void)handleArtistAlertsTap {
    self.artist.artistAlerts = !self.artist.artistAlerts;
    [self.artistAlertsBarButton setImage:[self artistAlertsImage]];
}

- (void)configureArtistCollectionView {
    CSStickyHeaderFlowLayout *layout = [CSStickyHeaderFlowLayout new];
    layout.minimumLineSpacing = 0;

    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 225);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 44);
        layout.parallaxHeaderAlwaysOnTop = YES;

        // If we want to disable the sticky header effect
        layout.disableStickyHeaders = YES;
    }

    self.artistCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.artistCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.artistCollectionView.alwaysBounceVertical = YES;
    self.artistCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.artistCollectionViewModel = [[DILArtistCollectionViewModel alloc] initWithArtist:self.artist];
    self.artistCollectionViewModel.delegate = self;

    self.artistCollectionView.dataSource = self.artistCollectionViewModel;
    self.artistCollectionView.delegate = self.artistCollectionViewModel;

    [self.view addSubview:self.artistCollectionView];
    [self.artistCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)setArtist:(DILPFArtist *)artist {
    _artist = artist;
    [self configureArtistCollectionView];
}

- (void)reloadSection:(NSUInteger)section {
    [self.artistCollectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
//    [self.artistCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)presentVideoPlayerViewController:(XCDYouTubeVideoPlayerViewController *)player {
    [self presentViewController:player animated:YES completion:NULL];
}
@end
