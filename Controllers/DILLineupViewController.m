//
//  DILLineUpViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupViewController.h"

#import "DILLineupCollectionViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <PromiseKit/PromiseKit.h>

#import "DILArtistViewController.h"
#import "DILStageSelectTitleView.h"

@interface DILLineupViewController ()<DILLineupCollectionViewDelegate, DILStageSelectTitleViewDelegate>
@property (strong, nonatomic) UICollectionView *lineupCollectionView;
@property (strong, nonatomic) DILLineupCollectionViewModel *lineupCollectionViewModel;
@property (strong, nonatomic) UIButton *lineupNavigationTitleButton;
@property (strong, nonatomic) NSArray *stageArray;
@property (nonatomic) BOOL waitingForStageFetch;
@property (strong, nonatomic) DILStageSelectTitleView *stageSelectTitleView;
@property (strong, nonatomic) NSMutableArray *stageSelectTitleViewAutoLayoutConstraintArray;
@end

@implementation DILLineupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.stageSelectTitleViewAutoLayoutConstraintArray = [NSMutableArray new];
    [self configureLineupCollectionView];
    [self configureStageSelectionTitleView];
//    [self.lineupCollectionViewModel configurePullToRefresh];

    [self fetchStages];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recieveAnnouncementAnimationEndedNotification:)
                                                 name:@"announcementAnimationEndedNotification"
                                               object:nil];
}

- (void)configureLineupCollectionView {
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    self.lineupCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.lineupCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineupCollectionViewModel = [DILLineupCollectionViewModel new];
    self.lineupCollectionViewModel.collectionView = self.lineupCollectionView;
    self.lineupCollectionViewModel.delegate = self;
    
    self.lineupCollectionView.dataSource = self.lineupCollectionViewModel;
    self.lineupCollectionView.delegate = self.lineupCollectionViewModel;
    self.lineupCollectionView.showsVerticalScrollIndicator = NO;
    self.lineupCollectionView.alwaysBounceVertical = YES;
    self.lineupCollectionView.backgroundColor = [DilloDayStyleKit notificationCellBackgroundColor];

    [self.view addSubview:self.lineupCollectionView];
    [self.lineupCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

}

- (void)configureStageSelectionTitleView {
    self.stageSelectTitleView = [[DILStageSelectTitleView alloc] initForAutoLayoutWithViewController:self];
    self.stageSelectTitleView.viewController = self;
    self.stageSelectTitleView.delegate = self;
    self.navigationItem.titleView = self.stageSelectTitleView;
    [self.stageSelectTitleViewAutoLayoutConstraintArray addObject:[self.stageSelectTitleView autoAlignAxisToSuperviewAxis:ALAxisVertical]];
    [self.stageSelectTitleViewAutoLayoutConstraintArray addObject:[self.stageSelectTitleView autoAlignAxisToSuperviewAxis:ALAxisHorizontal]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.stageSelectTitleView.translatesAutoresizingMaskIntoConstraints = YES;
    for (NSLayoutConstraint *constraint in self.stageSelectTitleViewAutoLayoutConstraintArray) {
        [constraint autoRemove];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.stageSelectTitleView.translatesAutoresizingMaskIntoConstraints = NO;
    for (NSLayoutConstraint *constraint in self.stageSelectTitleViewAutoLayoutConstraintArray) {
        [constraint autoInstall];
    }
}

- (void)recieveAnnouncementAnimationEndedNotification:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"announcementAnimationEndedNotification"]) {
        self.lineupCollectionViewModel.announcementHasEnded = YES;
        [self.lineupCollectionViewModel.announcementCellViewController removeVideo];
        [self.lineupCollectionViewModel.announcementCellViewController.cell loadParallaxImage];
        self.lineupCollectionViewModel.announcementCellViewController.cell.userInteractionEnabled = YES;
    }
}

- (void)initLineupForStage:(DILPFStage *)stage {
    self.stageSelectTitleView.selectedStage = stage;
    self.lineupCollectionViewModel.stage = stage;
    [self.lineupCollectionView reloadData];
    [self.lineupCollectionView setContentOffset:CGPointZero animated:NO];
}

#pragma mark - DILLineupCollectionViewDelegate
- (void)didSelectArtist:(DILPFArtist *)artist {
    if (self.lineupCollectionViewModel.announcementHasEnded) {
        if ([artist.announced boolValue]) {
            DILArtistViewController *artistVC = [DILArtistViewController new];
            artistVC.artist = artist;
            [self showViewController:artistVC sender:self];
        } else {
            [SVProgressHUD showInfoWithStatus:@"Artist not yet announced!"];
        }
    }
}

#pragma mark - DILStageSelectionDelegate
- (void)didSelectStage:(DILPFStage *)stage {
    if (self.lineupCollectionViewModel.announcementHasEnded) {
        self.stageSelectTitleView.selectedStage = stage;
        self.lineupCollectionViewModel.stage = stage;
        [self.lineupCollectionView reloadData];
        [self.lineupCollectionView setContentOffset:CGPointZero animated:NO];
    }
}

#pragma mark - Promises
- (void)fetchStages {
    [SVProgressHUD show];
    [self stageQueryPromise].then(^(NSArray *stages) {
        [SVProgressHUD dismiss];
        self.stageArray = stages;
        
        self.lineupCollectionViewModel.announcementHasEnded = YES;
        for (DILPFStage *stage in stages)
            for (DILPFArtist *artist in stage.artists)
                if (artist.isBeingAnnounced)
                    self.lineupCollectionViewModel.announcementHasEnded = NO;
        [self initLineupForStage:[stages firstObject]];
    });
}

- (PMKPromise *)stageQueryPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        PFQuery *stageQuery = [DILPFStage query];
        [stageQuery orderByAscending:@"order"];
        [stageQuery includeKey:kDILPFStageArtistsKey];
        [stageQuery includeKey:[NSString stringWithFormat:@"%@.%@",kDILPFStageArtistsKey,kDILPFArtistSponsorKey]];
        [stageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                reject(error);
            } else {
                fulfill(objects);
            }
        }];
    }];
}
@end
