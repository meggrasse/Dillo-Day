//
//  DILLineupCollectionViewModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupCollectionViewModel.h"

#import "DILLineupCenterTextCollectionViewCell.h"
#import "Artist.h"
#import "DILPFArtist.h"

#import <PromiseKit/PromiseKit.h>

@interface DILLineupCollectionViewModel()
@end

static NSString *const DILLineupCenterTextCollectionViewCellIdentifier = @"DILLineupCenterTextCollectionViewCellIdentifier";

@implementation DILLineupCollectionViewModel
- (id)init {
    if (self = [super init]) {

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
    static dispatch_once_t classRegisterToken;
    dispatch_once(&classRegisterToken, ^{
        [collectionView registerClass:[DILLineupCenterTextCollectionViewCell class] forCellWithReuseIdentifier:DILLineupCenterTextCollectionViewCellIdentifier];
    });

    DILLineupCenterTextCollectionViewCell *lineupCell = [collectionView dequeueReusableCellWithReuseIdentifier:DILLineupCenterTextCollectionViewCellIdentifier forIndexPath:indexPath];
    DILPFArtist *artistForCell = [self artistForIndexPath:indexPath];
    [lineupCell configureCellWithArtist:artistForCell];
    
    return lineupCell;
}

- (DILPFArtist *)artistForIndexPath:(NSIndexPath *)indexPath {
    return self.stage.artists[indexPath.row];
}

#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(CGRectGetWidth(collectionView.bounds), 150);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

@end
