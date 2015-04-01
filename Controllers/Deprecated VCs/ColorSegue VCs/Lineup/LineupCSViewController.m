//
//  LineupCSViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "LineupCSViewController.h"
#import <PureLayout/PureLayout.h>
#import "LineupTextHTKCollectionViewCell.h"
#import "LineupModel.h"

static NSString *LineupTextHTKCollectionViewCellIdentifier = @"LineupTextHTKCollectionViewCellIdentifier";

@interface LineupCSViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *lineupCollectionView;
@property (strong, nonatomic) LineupModel *lineupModel;
@end

@implementation LineupCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDilloButtonToUnwindOnTap:YES];
    [self configureLineupCollectionView];
    [self configureLineupModel];
    
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
    if (self.dilloButton) {
        [self.view insertSubview:self.lineupCollectionView belowSubview:self.dilloButton];
    } else {
        [self.view addSubview:self.lineupCollectionView];
    }
    [self.lineupCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    if (self.dilloButton) {
        [self.lineupCollectionView setContentInset:UIEdgeInsetsMake(CGRectGetMaxY(self.dilloButton.frame), 0, 0, 0)];
        self.lineupCollectionView.layer.zPosition = self.dilloButton.layer.zPosition - 1;
    }
    
    self.lineupCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.lineupCollectionView registerClass:[LineupTextHTKCollectionViewCell class] forCellWithReuseIdentifier:LineupTextHTKCollectionViewCellIdentifier];
}

#pragma mark - UICollectionView Delegate Implementation
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.lineupModel numberOfItemsInSection:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.lineupModel numberOfSections];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LineupTextHTKCollectionViewCell *lineupCell = [collectionView dequeueReusableCellWithReuseIdentifier:LineupTextHTKCollectionViewCellIdentifier forIndexPath:indexPath];
    [self configureLineupHTKCollectionViewCell:lineupCell ForRowAtIndexPath:indexPath];
    return lineupCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize defaultSize = DEFAULT_LINEUP_TEXT_CELL_SIZE;
    return [LineupTextHTKCollectionViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        [self configureLineupHTKCollectionViewCell:(LineupTextHTKCollectionViewCell *)cellToSetup ForRowAtIndexPath:indexPath];
        return cellToSetup;
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Artist *selectedArtist = [self.lineupModel artistForRowAtIndexPath:indexPath];
}

#pragma mark - Helper Methods
- (void)configureLineupHTKCollectionViewCell:(LineupTextHTKCollectionViewCell *)lineupCell ForRowAtIndexPath:(NSIndexPath *)indexPath {
    Artist *artistForCell = [self.lineupModel artistForRowAtIndexPath:indexPath];
    [lineupCell setupCellWithArtist:artistForCell.name atTime:artistForCell.time];
}
@end
