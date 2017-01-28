//
//  DILMapViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILMapViewController.h"
#import <SMScrollView/SMScrollView.h>
#import <PromiseKit/PromiseKit.h>

#import "DILPFMap.h"

@interface DILMapViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *mapImageView;
@property (strong, nonatomic) SMScrollView *scrollView;
@property (strong, nonatomic) DILPFMap *map;
@property (strong, nonatomic) UIImage *mapImage;
@end

@implementation DILMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    [self downloadMap];
}

- (void)configureView {
    [self.view addSubview:self.scrollView];
    [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.scrollView.backgroundColor = [UIColor clearColor];
}

- (void)configureMapImageView {
    self.mapImageView.image = self.mapImage;
    [self.scrollView addSubview:self.mapImageView];
    [self.mapImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView];
    [self.mapImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.mapImageView withMultiplier:self.mapImage.size.height/self.mapImage.size.width];
    
    self.scrollView.alpha = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.000001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.zoomScale += 0.001;
        self.scrollView.alpha = 1;
    });
}

- (UIImageView *)mapImageView {
    if (!_mapImageView) {
        _mapImageView = [[UIImageView alloc] initForAutoLayout];
    }
    return _mapImageView;
}

- (SMScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[SMScrollView alloc] initForAutoLayout];
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)downloadMap {
    UILabel *downloadLabel = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:downloadLabel];
    [downloadLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-50 relation:NSLayoutRelationLessThanOrEqual];
    downloadLabel.font = [UIFont boldFlatFontOfSize:50];
    downloadLabel.textColor = [DilloDayStyleKit fontColor];
    downloadLabel.adjustsFontSizeToFitWidth = YES;
    downloadLabel.minimumScaleFactor = 0.01;
    downloadLabel.numberOfLines = 1;
    downloadLabel.text = @"DOWNLOADING MAP";
    [downloadLabel sizeToFit];
    downloadLabel.textAlignment = NSTextAlignmentCenter;
    [downloadLabel autoCenterInSuperview];
    
    [self mapFetchPromise].then(^(DILPFMap *map){
        self.map = map;
        return [self mapFileDownloadPromise:map];
    }).then(^(NSData *mapImageData){
        self.mapImage = [UIImage imageWithData:mapImageData];
        [self configureMapImageView];
    });
    
    [downloadLabel removeFromSuperview];
}

- (PMKPromise *)mapFetchPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        PFQuery *mapQuery = [DILPFMap query];
        [mapQuery whereKey:@"currentMap" equalTo:@(YES)];
        [mapQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects) {
                fulfill([objects firstObject]);
            } else {
                reject(error);
            }
        }];
    }];
}

- (PMKPromise *)mapFileDownloadPromise:(DILPFMap *)map {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [map.mapFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (data) {
                fulfill(data);
            } else {
                reject(error);
            }
        }];
    }];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mapImageView;
}

@end
