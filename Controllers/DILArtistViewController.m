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

@interface DILArtistViewController ()<DILArtistCollectionViewModelDelegate>
@property (strong, nonatomic) UICollectionView *artistCollectionView;
@property (strong, nonatomic) DILArtistCollectionViewModel *artistCollectionViewModel;
@end

@implementation DILArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
}
@end
