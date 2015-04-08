//
//  DILSwipeLineupViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILSwipeLineupViewController.h"
#import "DILLineupCollectionViewController.h"
#import "DILArtistViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <PromiseKit/PromiseKit.h>

@interface DILSwipeLineupViewController ()<DILLineupCollectionViewControllerDelegate, GUITabPagerDataSource, GUITabPagerDelegate>

@property (strong, nonatomic) NSArray *stageArray;
@property (strong, nonatomic) NSArray *lineupCollectionViewControllerArray;
@end

@implementation DILSwipeLineupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    [self fetchStages];

}
- (void)configureSwipeNavigationController {
    [self reloadData];
}

- (NSArray *)createLineupCollectionViewControllersForStages:(NSArray *)stages {
    NSMutableArray *collectionViewArray = [NSMutableArray new];
    for (DILPFStage *stage in stages) {
        DILLineupCollectionViewController *lineupCollectionVC = [[DILLineupCollectionViewController alloc] initWithStage:stage];
        lineupCollectionVC.delegate = self;
        [collectionViewArray addObject:lineupCollectionVC];
    }
    return collectionViewArray;
}

#pragma mark - GUITabPagerDataSource
- (NSInteger)numberOfViewControllers {
    return self.stageArray.count;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    return self.lineupCollectionViewControllerArray[index];
}

#pragma mark - GUITabPagerDelegate 
- (NSString *)titleForTabAtIndex:(NSInteger)index {
    return [(DILPFStage *)self.stageArray[index] name];
}

- (CGFloat)tabHeight {
    return 40.0;
}

-  (UIColor *)tabColor {
    return [UIColor whiteColor];
}

- (UIFont *)titleFont {
    return [UIFont systemFontOfSize:20];
}

- (UIColor *)tabBackgroundColor {
    return [DilloDayStyleKit navigationBarColor];
}

- (void)tabPager:(GUITabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index {
    DILLineupCollectionViewController *lineupVC = self.lineupCollectionViewControllerArray[index];
    [lineupVC reloadData];
}

#pragma mark - DILLineupCollectionViewControllerDelegate
- (void)didSelectArtist:(DILPFArtist *)artist {
    DILArtistViewController *artistVC = [DILArtistViewController new];
    artistVC.artist = artist;
    [self showViewController:artistVC sender:self];
}

#pragma mark - Promises
- (void)fetchStages {
    [SVProgressHUD show];
    [self stageQueryPromise].then(^(NSArray *stages) {
        [SVProgressHUD dismiss];
        self.stageArray = stages;
        self.lineupCollectionViewControllerArray = [self createLineupCollectionViewControllersForStages:stages];
        [self configureSwipeNavigationController];
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
