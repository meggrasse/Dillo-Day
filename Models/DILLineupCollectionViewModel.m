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

@interface DILLineupCollectionViewModel()
@property (nonatomic) BOOL hasRegisteredClass;
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stage.artists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.hasRegisteredClass) {
        [collectionView registerClass:[DILLineupCenterTextCollectionViewCell class] forCellWithReuseIdentifier:DILLineupCenterTextCollectionViewCellIdentifier];
        [collectionView registerClass:[DILLineupParallaxCollectionViewCell class] forCellWithReuseIdentifier:DILLineupParallaxCollectionViewCellIdentifier];
        self.hasRegisteredClass = YES;
    }

    DILLineupParallaxCollectionViewCell *parallaxLineupCell = [collectionView dequeueReusableCellWithReuseIdentifier:DILLineupParallaxCollectionViewCellIdentifier forIndexPath:indexPath];
    DILPFArtist *artistForCell = [self artistForIndexPath:indexPath];
    [parallaxLineupCell configureCellWithArtist:artistForCell scrollView:collectionView];
    return parallaxLineupCell;


    /*
    DILLineupCenterTextCollectionViewCell *lineupCell = [collectionView dequeueReusableCellWithReuseIdentifier:DILLineupCenterTextCollectionViewCellIdentifier forIndexPath:indexPath];
    DILPFArtist *artistForCell = [self artistForIndexPath:indexPath];
    [lineupCell configureCellWithArtist:artistForCell];

    lineupCell.layer.shouldRasterize = YES;
    lineupCell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return lineupCell;
     */
}

- (DILPFArtist *)artistForIndexPath:(NSIndexPath *)indexPath {
    return self.stage.artists[indexPath.row];
}

#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(CGRectGetWidth(collectionView.bounds), 175);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectArtist:[self artistForIndexPath:indexPath]];
}

@end
