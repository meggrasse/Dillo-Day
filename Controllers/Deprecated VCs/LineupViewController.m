//
//  LineupViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/21/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "LineupViewController.h"

#import "LineupTextHTKCollectionViewCell.h"
#import "LineupCollectionViewCell.h"
#import "LineupModel.h"

#import "ArtistInfoViewController.h"

@interface LineupViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *lineupCollectionView;
@property (strong, nonatomic) LineupModel *lineupModel;
@end

static NSString *LineupTextHTKCollectionViewCellIdentifier = @"LineupTextHTKCollectionViewCellIdentifier";
static NSString *LineupCollectionViewCellIdentifier = @"LineupCollectionViewCellIdentifier";

@implementation LineupViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureLineupCollectionView];
    [self configureLineupModel];
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Lineup";
    
}

- (void)configureLineupModel {
    self.lineupModel = [LineupModel new];
}

- (void)configureLineupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    
    self.lineupCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.lineupCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineupCollectionView.alwaysBounceVertical = YES;
    
    self.lineupCollectionView.delegate = self;
    self.lineupCollectionView.dataSource = self;
    
    [self.view addSubview:self.lineupCollectionView];
    [self.lineupCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    self.lineupCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.lineupCollectionView registerClass:[LineupTextHTKCollectionViewCell class] forCellWithReuseIdentifier:LineupTextHTKCollectionViewCellIdentifier];
    
    [self.lineupCollectionView registerClass:[LineupCollectionViewCell class] forCellWithReuseIdentifier:LineupCollectionViewCellIdentifier];
}

#pragma mark - UICollectionView Delegate Implementation
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.lineupModel numberOfItemsInSection:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.lineupModel numberOfSections];
}

/*
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LineupTextHTKCollectionViewCell *lineupCell = [collectionView dequeueReusableCellWithReuseIdentifier:LineupTextHTKCollectionViewCellIdentifier forIndexPath:indexPath];
    [self configureLineupHTKCollectionViewCell:lineupCell ForRowAtIndexPath:indexPath];
    return lineupCell;
}
 */

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LineupCollectionViewCell *lineupCell = [collectionView dequeueReusableCellWithReuseIdentifier:LineupCollectionViewCellIdentifier forIndexPath:indexPath];
    [self configureLineupCollectionViewCell:lineupCell ForRowAtIndexPath:indexPath];
    
    CGFloat yOffset = ((self.lineupCollectionView.contentOffset.y - lineupCell.frame.origin.y) / lineupCell.imageViewHeight) * IMAGE_OFFSET_SPEED;
    lineupCell.imageOffset = CGPointMake(0.0f, yOffset);
    return lineupCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.lineupCollectionView.bounds), 275);
}

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize defaultSize = DEFAULT_LINEUP_TEXT_CELL_SIZE;
    return [LineupTextHTKCollectionViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        [self configureLineupHTKCollectionViewCell:(LineupTextHTKCollectionViewCell *)cellToSetup ForRowAtIndexPath:indexPath];
        return cellToSetup;
    }];
}
*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Artist *selectedArtist = [self.lineupModel artistForRowAtIndexPath:indexPath];
    ArtistInfoViewController *artistInfoVC = [[ArtistInfoViewController alloc] init];
    artistInfoVC.artist = selectedArtist;
    [self showViewController:artistInfoVC sender:self];
}

#pragma mark - UIScrollViewDelegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isMemberOfClass:[LineupCollectionViewCell class]]) {
        [self updateLineupCollectionViewCellParallax:(LineupCollectionViewCell *)cell];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for(UICollectionViewCell *cell in self.lineupCollectionView.visibleCells) {
        if ([cell isMemberOfClass:[LineupCollectionViewCell class]]) {
            [self updateLineupCollectionViewCellParallax:(LineupCollectionViewCell *)cell];
        }
    }
}

- (void)updateLineupCollectionViewCellParallax:(LineupCollectionViewCell *)cell {
    CGFloat yDifference = 2 * (CGRectGetMidY(self.lineupCollectionView.bounds) - CGRectGetMidY(cell.frame))/CGRectGetHeight(self.lineupCollectionView.bounds);
    cell.imageOffset = CGPointMake(0, -yDifference);
}

#pragma mark - Helper Methods
- (void)configureLineupHTKCollectionViewCell:(LineupTextHTKCollectionViewCell *)lineupCell ForRowAtIndexPath:(NSIndexPath *)indexPath {
    Artist *artistForCell = [self.lineupModel artistForRowAtIndexPath:indexPath];
    [lineupCell setupCellWithArtist:artistForCell.name atTime:artistForCell.time];
}

- (void)configureLineupCollectionViewCell:(LineupCollectionViewCell *)lineupCell ForRowAtIndexPath:(NSIndexPath *)indexPath {
    Artist *artistForCell = [self.lineupModel artistForRowAtIndexPath:indexPath];
    [lineupCell setupCellWithArtist:artistForCell];
}


+ (RDVTabBarItem *)tabBarItem {
    RDVTabBarItem *item = [[RDVTabBarItem alloc] init];
    item.title = @"lineup";
    item.unselectedTitleAttributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:0.5]};
    item.selectedTitleAttributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:1]};
    [item setFinishedSelectedImage:[UIImage imageNamed:@"DillogoSharpLarge"] withFinishedUnselectedImage:[UIImage imageNamed:@"left15"]];
    
    return item;
}

@end
