//
//  DILLineUpViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILLineupViewController.h"

#import "DILLineupCollectionViewModel.h"
#import "DILStageSelectionViewController.h"
#import <Modality/UIViewController+Modality.h>
#import <Modality/MODTransitionAnimatorSlideModal.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <PromiseKit/PromiseKit.h>

#import "DILArtistViewController.h"

@interface DILLineupViewController ()<DILStageSelectionDelegate, DILLineupCollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *lineupCollectionView;
@property (strong, nonatomic) DILLineupCollectionViewModel *lineupCollectionViewModel;
@property (strong, nonatomic) UIButton *lineupNavigationTitleButton;
@property (strong, nonatomic) NSArray *stageArray;
@property (nonatomic) BOOL waitingForStageFetch;
@end

@implementation DILLineupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureLineupCollectionView];
    [self configureTitleViewWithTitle:@"Main Stage"];

    [self fetchStages];
}

- (void)configureLineupCollectionView {
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    self.lineupCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.lineupCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineupCollectionViewModel = [DILLineupCollectionViewModel new];
    self.lineupCollectionViewModel.delegate = self;
    
    self.lineupCollectionView.dataSource = self.lineupCollectionViewModel;
    self.lineupCollectionView.delegate = self.lineupCollectionViewModel;

    [self.view addSubview:self.lineupCollectionView];
    [self.lineupCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

}

- (void)configureTitleViewWithTitle:(NSString *)title {
    self.lineupNavigationTitleButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.lineupNavigationTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.lineupNavigationTitleButton.titleLabel.font = [UIFont boldSystemFontOfSize:self.lineupNavigationTitleButton.titleLabel.font.pointSize];
    [self.lineupNavigationTitleButton setTitle:title forState:UIControlStateNormal];
    [self.lineupNavigationTitleButton addTarget:self action:@selector(handleLineupNavigationTitleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.lineupNavigationTitleButton sizeToFit];

    self.navigationItem.titleView = self.lineupNavigationTitleButton;
}

- (void)handleLineupNavigationTitleButtonTapped {
    [self displayStageSelection];
}

- (void)displayStageSelection {
    if (self.stageArray) {
        DILStageSelectionViewController *stageSelectionVC = [DILStageSelectionViewController new];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:stageSelectionVC];
        stageSelectionVC.delegate = self;
        stageSelectionVC.stageArray = self.stageArray;

        CGFloat modalViewLength = [stageSelectionVC heightForViewController];
        if (modalViewLength) {
            MODTransitionAnimatorSlideModal *modalSlideAnimator = [MODTransitionAnimatorSlideModal transitionAnimatorWithDirection:MODDirectionTop destinationViewLength:modalViewLength];
            [self MOD_presentViewController:navController withTransitionAnimator:modalSlideAnimator duration:MODDefaulTransitionDuration completion:^{
                
            }];
        }
    }
}

#pragma mark - DILLineupCollectionViewDelegate
- (void)didSelectArtist:(DILPFArtist *)artist {
    DILArtistViewController *artistVC = [DILArtistViewController new];
    artistVC.artist = artist;
    [self showViewController:artistVC sender:self];
}

#pragma mark - DILStageSelectionDelegate
- (void)didSelectStage:(DILPFStage *)stage {
    self.lineupCollectionViewModel.stage = stage;
    [self.lineupCollectionView reloadData];
    [self.lineupNavigationTitleButton setTitle:stage.name forState:UIControlStateNormal];
    [self.lineupNavigationTitleButton sizeToFit];
}

#pragma mark - Promises
- (void)fetchStages {
    [SVProgressHUD show];
    [self stageQueryPromise].then(^(NSArray *stages) {
        [SVProgressHUD dismiss];
        self.stageArray = stages;
        [self didSelectStage:[stages firstObject]];
    });
}

- (PMKPromise *)stageQueryPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        PFQuery *stageQuery = [DILPFStage query];
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
