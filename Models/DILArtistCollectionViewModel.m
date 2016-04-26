//
//  DILArtistCollectionViewModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistCollectionViewModel.h"

#import "DILArtistBioHTKCollectionViewCell.h"
#import "DILArtistSponsorCollectionViewCell.h"
#import "DILArtistMusicViewCell.h"
#import "DILArtistStickyHeaderCollectionViewCell.h"

#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout.h>

@interface DILArtistCollectionViewModel()<DILArtistStickyHeaderCollectionViewCellDelegate>
@property (nonatomic) BOOL hasRegisteredSupplementaryClasses;
@property (nonatomic) BOOL hasRegisteredCellClasses;
@property (nonatomic) DILArtistInfoType artistInfoTypeForDisplay;
@end

@implementation DILArtistCollectionViewModel
- (id)initWithArtist:(DILPFArtist *)artist {
    if (self = [self init]) {
        self.artist = artist;
        //Switch to get platform links
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        self.hasRegisteredCellClasses = self.hasRegisteredSupplementaryClasses = NO;
        self.artistInfoTypeForDisplay = DILArtistInfoTypeBio;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    switch (self.artistInfoTypeForDisplay) {
        case DILArtistInfoTypeBio: {
            return 1;
        }
        case DILArtistInfoTypeMusic: {
            return 1;
        }
        default:
            return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (self.artistInfoTypeForDisplay) {
        case DILArtistInfoTypeBio: {
            if (self.artist.sponsor) {
                return 2;
            } else {
                return 1;
            }
        }
        case DILArtistInfoTypeMusic: {
            return 1;
        }
        default:
            return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.hasRegisteredCellClasses) {
        [collectionView registerClass:[DILArtistBioHTKCollectionViewCell class] forCellWithReuseIdentifier:[DILArtistBioHTKCollectionViewCell identifier]];
        [collectionView registerClass:[DILArtistSponsorCollectionViewCell class] forCellWithReuseIdentifier:[DILArtistSponsorCollectionViewCell identifier]];
        [collectionView registerClass:[DILArtistMusicViewCell class] forCellWithReuseIdentifier: [DILArtistMusicViewCell identifier]];
        self.hasRegisteredCellClasses = YES;
    }

    switch (self.artistInfoTypeForDisplay) {
        case DILArtistInfoTypeBio: {
            switch (indexPath.row) {
                case 0: {
                    if (self.artist.sponsor) {
                        DILArtistSponsorCollectionViewCell *sponsorCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DILArtistSponsorCollectionViewCell identifier] forIndexPath:indexPath];
                        sponsorCell.clipsToBounds = YES;
                        [sponsorCell configureCellWithSponsor:self.artist.sponsor];
                        return sponsorCell;
                    }
                }
                case 1: {
                    DILArtistBioHTKCollectionViewCell *bioCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DILArtistBioHTKCollectionViewCell identifier] forIndexPath:indexPath];
                    [bioCell configureCellWithArtist:self.artist];
                    return bioCell;
                }
                default:
                    return nil;
            }
        }
        case DILArtistInfoTypeMusic: { //double check this case name
            DILArtistMusicViewCell *musicCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DILArtistMusicViewCell identifier] forIndexPath:indexPath]; //doublecheck
            [musicCell configureCellWithArtist:self.artist];
            return musicCell;
        }

    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.hasRegisteredSupplementaryClasses) {
        [collectionView registerClass:[DILArtistStickyHeaderCollectionViewCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:[DILArtistStickyHeaderCollectionViewCell identifier]];
        self.hasRegisteredSupplementaryClasses = YES;
    }

    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
            UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:[DILArtistStickyHeaderCollectionViewCell identifier]
                                                                                   forIndexPath:indexPath];
        if ([cell isMemberOfClass:[DILArtistStickyHeaderCollectionViewCell class]]) {
            self.stickyHeaderCell = (DILArtistStickyHeaderCollectionViewCell *)cell;
            [self.stickyHeaderCell configureCellWithArtist:self.artist];
            self.stickyHeaderCell.delegate = self;

        }

        return cell;
    } else {
        return nil;
    }
    
}
#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.artistInfoTypeForDisplay) {
        case DILArtistInfoTypeBio: {
            switch (indexPath.row) {
                case 0: {
                    if (self.artist.sponsor) {
                        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 100);
                    }
                }
                case 1: {
                    CGSize cellSize = [DILArtistBioHTKCollectionViewCell sizeForCellWithDefaultSize:[DILArtistBioHTKCollectionViewCell defaultSize] setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
                        [(DILArtistBioHTKCollectionViewCell*)cellToSetup configureCellWithArtist:self.artist];
                        return cellToSetup;
                    }];
                    
                    return cellSize;
                }
                default:
                    return CGSizeZero;
            }
        }
        case DILArtistInfoTypeMusic: {
            CGFloat viewWidth = CGRectGetWidth(collectionView.bounds);
            CGFloat viewHeight = viewWidth/2 + 40.0;
            return CGSizeMake(viewWidth, viewHeight);
        }
        default:
            return CGSizeZero;
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 0, 15, 0);
}

#pragma mark - DILArtistStickyHeaderCollectionViewCellDelegate
- (void)displayArtistInfoType:(DILArtistInfoType)type {
    self.artistInfoTypeForDisplay = type;
    [self.delegate reloadSection:0];
}
@end
