//
//  DILLineupCollectionViewModel.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DILLineupCellViewController.h"
#import "DILPFStage.h"

@class DILLineupCollectionViewModel;
@protocol DILLineupCollectionViewDelegate <NSObject>
@required
- (void)didSelectArtist:(DILPFArtist *)artist;
@end

@interface DILLineupCollectionViewModel : NSObject<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) DILPFStage *stage;
@property (weak, nonatomic) id<DILLineupCollectionViewDelegate> delegate;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic) BOOL announcementHasEnded;
@property (nonatomic, strong) DILLineupCellViewController *announcementCellViewController;
- (void)configurePullToRefresh;
@end
