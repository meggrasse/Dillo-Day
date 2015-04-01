//
//  NotificationsViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "NotificationsViewController.h"
#import "NotificationModel.h"

#import "NotificationHTKCollectionViewCell.h"

@interface NotificationsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NotificationModel *notificationModel;
@end

static NSString *NotificationHTKCollectionViewCellIdentifier = @"NotificationHTKCollectionViewCellIdentifier";

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.notificationModel = [NotificationModel new];
    [self configureCollectionView];
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    [collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.contentInset = UIEdgeInsetsZero;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.alwaysBounceVertical = YES;
    collectionView.clipsToBounds = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerClass:[NotificationHTKCollectionViewCell class] forCellWithReuseIdentifier:NotificationHTKCollectionViewCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate Implementations
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.notificationModel numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.notificationModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NotificationHTKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NotificationHTKCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setupCellWithNotification:[self.notificationModel notificationForRowAtIndexPath:indexPath]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize defaultSize = DEFAULT_NOTIFICATION_CELL_SIZE;
    CGSize cellSize = [NotificationHTKCollectionViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        [(NotificationHTKCollectionViewCell*)cellToSetup setupCellWithNotification:[self.notificationModel notificationForRowAtIndexPath:indexPath]];
        return cellToSetup;
    }];
    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
