//
//  DILLineupCollectionViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupCollectionViewController.h"
#import "DILLineupCollectionViewModel.h"

@interface DILLineupCollectionViewController ()<DILLineupCollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *lineupCollectionView;
@property (strong, nonatomic) DILLineupCollectionViewModel *lineupCollectionViewModel;
@end

@implementation DILLineupCollectionViewController
- (id)initWithStage:(DILPFStage *)stage {
    if (self = [super init]) {
        self.stage = stage;
    }
    return self;
}
- (void)reloadData {
    [self.lineupCollectionView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureLineupCollectionView];
}

- (void)configureLineupCollectionView {
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    self.lineupCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.lineupCollectionView.translatesAutoresizingMaskIntoConstraints = NO;

    self.lineupCollectionViewModel = [DILLineupCollectionViewModel new];
    self.lineupCollectionViewModel.delegate = self;
    self.lineupCollectionViewModel.stage = self.stage;

    self.lineupCollectionView.dataSource = self.lineupCollectionViewModel;
    self.lineupCollectionView.delegate = self.lineupCollectionViewModel;
    self.lineupCollectionView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:self.lineupCollectionView];
    [self.lineupCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - DILLineupCollectionViewDelegate
- (void)didSelectArtist:(DILPFArtist *)artist {
    [self.delegate didSelectArtist:artist];
}

@end
