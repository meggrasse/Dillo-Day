//
//  ArtistInfoViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/21/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "ArtistInfoViewController.h"
#import "ArtistInfoHeaderHTKCollectionReusableViewCell.h"
#import "ArtistInfoAboutHTKCollectionViewCell.h"
#import "ArtistInfoVideoCollectionViewCell.h"

@interface ArtistInfoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *infoCollectionView;
@end


static NSString *ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier = @"ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier";
static NSString *ArtistInfoAboutHTKCollectionViewCellIdentifier = @"ArtistInfoAboutHTKCollectionViewCellIdentifier";
static NSString *ArtistInfoVideoCollectionViewCellIdentifier = @"ArtistInfoVideoCollectionViewCellIdentifier";

@implementation ArtistInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureInfoCollectionView];
    // Do any additional setup after loading the view.
}

- (void)configureInfoCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.infoCollectionView = collectionView;
    
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.alwaysBounceVertical = YES;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    [collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerClass:[ArtistInfoHeaderHTKCollectionReusableViewCell class] forCellWithReuseIdentifier:ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier];
    [collectionView registerClass:[ArtistInfoAboutHTKCollectionViewCell class] forCellWithReuseIdentifier:ArtistInfoAboutHTKCollectionViewCellIdentifier];
    [collectionView registerClass:[ArtistInfoVideoCollectionViewCell class] forCellWithReuseIdentifier:ArtistInfoVideoCollectionViewCellIdentifier];
    
//    [self.collectionView registerClass:[LineupTextHTKCollectionViewCell class] forCellWithReuseIdentifier:LineupTextHTKCollectionViewCellIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else return [self.artist.youtubeVideos count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ArtistInfoHeaderHTKCollectionReusableViewCell *artistHeaderCell = [collectionView dequeueReusableCellWithReuseIdentifier:ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier forIndexPath:indexPath];
            [artistHeaderCell setupCellWithArtist:self.artist];

            return artistHeaderCell;
        } else {
            ArtistInfoAboutHTKCollectionViewCell *artistAboutCell = [collectionView dequeueReusableCellWithReuseIdentifier:ArtistInfoAboutHTKCollectionViewCellIdentifier forIndexPath:indexPath];
            [artistAboutCell setupCelWithArtist:self.artist];
            
            return artistAboutCell;
        }
    } else {
        ArtistInfoVideoCollectionViewCell *artistVideoCell = [collectionView dequeueReusableCellWithReuseIdentifier:ArtistInfoVideoCollectionViewCellIdentifier forIndexPath:indexPath];
        [artistVideoCell setupCellWithVideo:self.artist.youtubeVideos[indexPath.row]];
        return artistVideoCell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return CGSizeMake(CGRectGetWidth(self.infoCollectionView.bounds), 275);
        } else {
            CGSize defaultSize = DEFAULT_ARTIST_INFO_ABOUT_CELL_SIZE;
            return [ArtistInfoAboutHTKCollectionViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
                [(ArtistInfoAboutHTKCollectionViewCell*)cellToSetup setupCelWithArtist:self.artist];
                return cellToSetup;
            }];
        }
    } else {
        CGFloat videoCellWidth = (CGRectGetWidth(self.infoCollectionView.bounds) - 10*3)/2.0;
        return CGSizeMake(videoCellWidth, videoCellWidth);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    } else if (section == 1) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    } else return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat minimumLineSpacing;
    if (section == 1) {
        minimumLineSpacing = 10;
    }
    
    return minimumLineSpacing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        XCDYouTubeVideo *selectedVideo = self.artist.youtubeVideos[indexPath.row];
        
        XCDYouTubeVideoPlayerViewController *playerVC = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:selectedVideo.identifier];
        [self presentMoviePlayerViewControllerAnimated:playerVC];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
