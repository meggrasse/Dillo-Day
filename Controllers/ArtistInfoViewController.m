//
//  ArtistInfoViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/21/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "ArtistInfoViewController.h"
#import "ArtistInfoHeaderHTKCollectionReusableViewCell.h"

@interface ArtistInfoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *infoCollectionView;
@end


static NSString *ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier = @"ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier";
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
    
//    [self.collectionView registerClass:[LineupTextHTKCollectionViewCell class] forCellWithReuseIdentifier:LineupTextHTKCollectionViewCellIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArtistInfoHeaderHTKCollectionReusableViewCell *artistHeaderCell = [collectionView dequeueReusableCellWithReuseIdentifier:ArtistInfoHeaderHTKCollectionReusableViewCellIdentifier forIndexPath:indexPath];
    [artistHeaderCell setupCellWithArtist:self.artist];
    
    return artistHeaderCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.infoCollectionView.bounds), 275);
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
