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
#import "ArtistInfoAlwaysOnTopHeaderCollectionViewCell.h"

#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayout.h>

@interface ArtistInfoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ArtistInfoAlwaysOnHeaderTopDelegate>
@property (strong, nonatomic) UICollectionView *infoCollectionView;
@property (nonatomic) ArtistInfoType type;
@end


static NSString *ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier = @"ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier";
static NSString *ArtistInfoAboutHTKCollectionViewCellIdentifier = @"ArtistInfoAboutHTKCollectionViewCellIdentifier";
static NSString *ArtistInfoVideoCollectionViewCellIdentifier = @"ArtistInfoVideoCollectionViewCellIdentifier";
static NSString *ArtistInfoAlwaysOnTopHeaderCollectionViewCellIdentifier = @"ArtistInfoAlwaysOnTopHeaderCollectionViewCellIdentifier";

@implementation ArtistInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureInfoCollectionView];
    self.type = ArtistInfoTypeBio;
    // Do any additional setup after loading the view.
//    [self.navigationController setNavigationBarHidden:YES];
//    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)configureInfoCollectionView {
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CSStickyHeaderFlowLayout *layout = [CSStickyHeaderFlowLayout new];
    layout.minimumLineSpacing = 0;
    
    
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 300);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 44+70);
        layout.parallaxHeaderAlwaysOnTop = YES;
        
        // If we want to disable the sticky header effect
        layout.disableStickyHeaders = YES;
    }
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.infoCollectionView = collectionView;
    
    collectionView.contentInset = UIEdgeInsetsZero;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.alwaysBounceVertical = YES;
    collectionView.clipsToBounds = YES;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    [collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerClass:[ArtistInfoHeaderHTKCollectionReusableViewCell class] forCellWithReuseIdentifier:ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier];
    [collectionView registerClass:[ArtistInfoAboutHTKCollectionViewCell class] forCellWithReuseIdentifier:ArtistInfoAboutHTKCollectionViewCellIdentifier];
    [collectionView registerClass:[ArtistInfoVideoCollectionViewCell class] forCellWithReuseIdentifier:ArtistInfoVideoCollectionViewCellIdentifier];
    [collectionView registerClass:[ArtistInfoAlwaysOnTopHeaderCollectionViewCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:ArtistInfoAlwaysOnTopHeaderCollectionViewCellIdentifier];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CSAlwaysOnTopHeader" bundle:nil]
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"header"];

    
//    [self.collectionView registerClass:[LineupTextHTKCollectionViewCell class] forCellWithReuseIdentifier:LineupTextHTKCollectionViewCellIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/*
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
 */

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArtistInfoAboutHTKCollectionViewCell *artistAboutCell = [collectionView dequeueReusableCellWithReuseIdentifier:ArtistInfoAboutHTKCollectionViewCellIdentifier forIndexPath:indexPath];
    [artistAboutCell setupCelWithArtist:self.artist];
    
    return artistAboutCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        NSString *identifier = ArtistInfoAlwaysOnTopHeaderCollectionViewCellIdentifier;
//        NSString *identifier = @"header";
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:identifier
                                                                                   forIndexPath:indexPath];
        if ([cell isMemberOfClass:[ArtistInfoAlwaysOnTopHeaderCollectionViewCell class]]) {
            [((ArtistInfoAlwaysOnTopHeaderCollectionViewCell *)cell) setupCellWithArtist:self.artist];
        }
        
        return cell;
    }
    
    return nil;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize defaultSize = DEFAULT_ARTIST_INFO_ABOUT_CELL_SIZE;
    CGSize cellSize = [ArtistInfoAboutHTKCollectionViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        [(ArtistInfoAboutHTKCollectionViewCell*)cellToSetup setupCelWithArtist:self.artist];
        return cellToSetup;

    }];
    
    return cellSize;
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

#pragma mark - ArtistInfoAlwaysOnTopDelegate
- (void)displayArtistInfo:(ArtistInfoType)type {
    
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
