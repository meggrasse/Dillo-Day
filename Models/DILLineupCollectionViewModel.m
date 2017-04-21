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
#import "DILLineupCellViewController.h"

#import "DILPFArtist.h"

#import <PromiseKit/PromiseKit.h>
#import <CBStoreHouseRefreshControl/CBStoreHouseRefreshControl.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface DILLineupCollectionViewModel()
@property (nonatomic) BOOL hasRegisteredClass;
@property (strong, nonatomic) CBStoreHouseRefreshControl *refreshControl;
@property (readonly, nonatomic) NSArray *sortedArtistArray;
@property (nonatomic, strong) DILLineupCellViewController *announcementCellViewController;
@end

static NSString *const DILLineupCenterTextCollectionViewCellIdentifier = @"DILLineupCenterTextCollectionViewCellIdentifier";
static NSString *const DILLineupParallaxCollectionViewCellIdentifier = @"DILLineupParallaxCollectionViewCellIdentifier";

@implementation DILLineupCollectionViewModel
- (id)init {
    if (self = [super init]) {
        self.hasRegisteredClass = NO;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSArray *)sortedArtistArray {
    NSMutableArray *unsortedArray = [self.stage.artists mutableCopy];
    [unsortedArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        DILPFArtist *LHS = (DILPFArtist *)obj1;
        DILPFArtist *RHS = (DILPFArtist *)obj2;
        return [RHS.lineupCollectionViewOrder compare:LHS.lineupCollectionViewOrder];
    }];
    return unsortedArray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sortedArtistArray.count;
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
        [lineupCell addSubview:self.announcementCellViewController.view];
        [lineupCell sendSubviewToBack:self.announcementCellViewController.view];
    }
    
    return lineupCell;
}

- (DILPFArtist *)artistForIndexPath:(NSIndexPath *)indexPath {
    return self.sortedArtistArray[indexPath.row];
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



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DILPFArtist *selectedArtist = [self artistForIndexPath:indexPath];
    if ([selectedArtist.announced boolValue]) {
        [self.delegate didSelectArtist:selectedArtist];
    } else {
        [SVProgressHUD showInfoWithStatus:@"Artist not yet announced!"];
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
