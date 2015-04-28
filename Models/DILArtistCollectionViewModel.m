//
//  DILArtistCollectionViewModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILArtistCollectionViewModel.h"

#import "DILArtistStickyHeaderCollectionViewCell.h"
#import "DILArtistBioHTKCollectionViewCell.h"
#import "DILArtistYoutubeVideoCollectionViewCell.h"
#import "DILArtistSponsorCollectionViewCell.h"

#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout.h>
#import "DILYoutubeVideoFetcher.h"

@interface DILArtistCollectionViewModel()<DILArtistStickyHeaderCollectionViewCellDelegate, DILYoutubeVideoFetcherDelegate>
@property (nonatomic) BOOL hasRegisteredSupplementaryClasses;
@property (nonatomic) BOOL hasRegisteredCellClasses;
@property (strong, nonatomic) NSMutableArray *videos;
@property (nonatomic) DILArtistInfoType artistInfoTypeForDisplay;
@end

@implementation DILArtistCollectionViewModel
- (id)initWithArtist:(DILPFArtist *)artist {
    if (self = [self init]) {
        self.artist = artist;
        [self fetchYoutubeVideos];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        self.hasRegisteredCellClasses = self.hasRegisteredSupplementaryClasses = NO;
        self.videos = [NSMutableArray new];
        self.artistInfoTypeForDisplay = DILArtistInfoTypeBio;
    }
    return self;
}

- (void)fetchYoutubeVideos {
    [[DILYoutubeVideoFetcher sharedVideoFetcher] fetchVideosForIds:self.artist.youtubeVideoIds forSender:self];
}

- (void)fetchedVideo:(XCDYouTubeVideo *)video image:(UIImage *)image {
    [self.videos addObject:video];
    if (self.artistInfoTypeForDisplay == DILArtistInfoTypeMusic) {
        NSUInteger indexOfVideo = [self.videos indexOfObject:video];
        [self.delegate insertItemAtIndex:[NSIndexPath indexPathForRow:indexOfVideo inSection:0]];
    }
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
            return self.videos.count;
        }
        default:
            return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.hasRegisteredCellClasses) {
        [collectionView registerClass:[DILArtistBioHTKCollectionViewCell class] forCellWithReuseIdentifier:[DILArtistBioHTKCollectionViewCell identifier]];
        [collectionView registerClass:[DILArtistYoutubeVideoCollectionViewCell class] forCellWithReuseIdentifier:[DILArtistYoutubeVideoCollectionViewCell identifier]];
        [collectionView registerClass:[DILArtistSponsorCollectionViewCell class] forCellWithReuseIdentifier:[DILArtistSponsorCollectionViewCell identifier]];
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
        case DILArtistInfoTypeMusic: {
            DILArtistYoutubeVideoCollectionViewCell *youtubeVideoCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DILArtistYoutubeVideoCollectionViewCell identifier] forIndexPath:indexPath];
            [youtubeVideoCell configureCellWithVideo:[self youtubeVideoForIndexPath:indexPath]];
            return youtubeVideoCell;
        }
        default:
            return nil;
    }

}

- (XCDYouTubeVideo *)youtubeVideoForIndexPath:(NSIndexPath *)indexPath {
    return self.videos[indexPath.row];
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
            DILArtistStickyHeaderCollectionViewCell *stickyHeaderCell = (DILArtistStickyHeaderCollectionViewCell *)cell;
            [stickyHeaderCell configureCellWithArtist:self.artist];
            stickyHeaderCell.delegate = self;

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
            CGFloat videoCellWidth = CGRectGetWidth(collectionView.bounds) - 15*2;
            CGFloat videoCellHeight = videoCellWidth * (9.0/16.0);
            return CGSizeMake(videoCellWidth, videoCellHeight);
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

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[collectionView cellForItemAtIndexPath:indexPath] isMemberOfClass:[DILArtistYoutubeVideoCollectionViewCell class]]) {
        XCDYouTubeVideo *video = [self youtubeVideoForIndexPath:indexPath];
        XCDYouTubeVideoPlayerViewController *youtubeVideoVC = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:video.identifier];
        [self.delegate presentVideoPlayerViewController:youtubeVideoVC];
    }
}

#pragma mark - DILArtistStickyHeaderCollectionViewCellDelegate
- (void)displayArtistInfoType:(DILArtistInfoType)type {
    self.artistInfoTypeForDisplay = type;
    [self.delegate reloadSection:0];
}
@end
