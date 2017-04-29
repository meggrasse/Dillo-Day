//
//  DILLineupCollectionViewModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupCollectionViewModel.h"

#import "DILLineupCenterTextCollectionViewCell.h"
#import "DILLineupParallaxCollectionViewCell.h"

#import "DILPFArtist.h"

#import <PromiseKit/PromiseKit.h>
#import <CBStoreHouseRefreshControl/CBStoreHouseRefreshControl.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface DILLineupCollectionViewModel()
@property (nonatomic) BOOL hasRegisteredClass;
@property (strong, nonatomic) CBStoreHouseRefreshControl *refreshControl;
@end

static NSString *const DILLineupCenterTextCollectionViewCellIdentifier = @"DILLineupCenterTextCollectionViewCellIdentifier";
static NSString *const DILLineupParallaxCollectionViewCellIdentifier = @"DILLineupParallaxCollectionViewCellIdentifier";

@implementation DILLineupCollectionViewModel
- (id)init {
    if (self = [super init]) {
        self.hasRegisteredClass = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(recieveAnnouncementAnimationEndedNotification:)
                                                     name:@"announcementAnimationEndedNotification"
                                                   object:nil];
        self.isAnnouncementFinished = YES;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.self.stage.artists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.hasRegisteredClass) {
        [collectionView registerClass:[DILLineupCenterTextCollectionViewCell class] forCellWithReuseIdentifier:DILLineupCenterTextCollectionViewCellIdentifier];
        [collectionView registerClass:[DILLineupParallaxCollectionViewCell class] forCellWithReuseIdentifier:DILLineupParallaxCollectionViewCellIdentifier];
        self.hasRegisteredClass = YES;
    }

    DILLineupParallaxCollectionViewCell *lineupCell = [collectionView dequeueReusableCellWithReuseIdentifier:DILLineupParallaxCollectionViewCellIdentifier forIndexPath:indexPath];

    DILPFArtist *artistForCell = [self artistForIndexPath:indexPath];
    [lineupCell configureCellWithArtist:artistForCell scrollView:collectionView];

    if (artistForCell.isBeingAnnounced && !self.announcementCellViewController) {
        self.announcementCellViewController = [[DILLineupCellViewController alloc] init];
        [self.announcementCellViewController setupYTPlayerViewForCell:lineupCell forArtist:artistForCell];
        self.isAnnouncementFinished = NO;
        [lineupCell.contentView addSubview:self.announcementCellViewController.view];
        [lineupCell.contentView sendSubviewToBack:lineupCell.parallaxImageView];
        [lineupCell.contentView bringSubviewToFront:lineupCell.centeredTextView];
    }
    
    return lineupCell;
}

- (DILPFArtist *)artistForIndexPath:(NSIndexPath *)indexPath {
    return self.self.stage.artists[indexPath.row];
}

#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(CGRectGetWidth(collectionView.bounds), 175);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}


- (void)recieveAnnouncementAnimationEndedNotification:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"announcementAnimationEndedNotification"]) {
        self.isAnnouncementFinished = YES;
        [self.announcementCellViewController removeVideo];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isAnnouncementFinished) {
        DILPFArtist *selectedArtist = [self artistForIndexPath:indexPath];
        if ([selectedArtist.announced boolValue]) {
            [self.delegate didSelectArtist:selectedArtist];
        } else {
            [SVProgressHUD showInfoWithStatus:@"Artist not yet announced!"];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.refreshControl scrollViewDidEndDragging];
}

#pragma mark - Pull to Refresh
- (void)configurePullToRefresh {
    self.refreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.collectionView
                                                                      target:self
                                                               refreshAction:@selector(refreshTriggered:)
                                                                   plist:@"storehouse"];
}


- (void)refreshTriggered:(CBStoreHouseRefreshControl *)refreshControl {
    [self.refreshControl finishingLoading];
}
@end
