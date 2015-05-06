//
//  DILShuttleScheduleViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILShuttleScheduleViewController.h"
#import <SMScrollView/SMScrollView.h>
#import <PromiseKit/PromiseKit.h>

#import "DILPFShuttleSchedule.h"

@interface DILShuttleScheduleViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) SMScrollView *scrollView;
@property (strong, nonatomic) DILPFShuttleSchedule *schedule;
@property (strong, nonatomic) UIImage *image;
@end

@implementation DILShuttleScheduleViewController

- (void)viewDidLoad {
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
        self.title = @"SHUTTLE SCHEDULE";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [DilloDayStyleKit navigationBarColor];
    [self.navigationController.navigationBar setTintColor:[DilloDayStyleKit tabBarSelectedColor]];
    self.view.backgroundColor = [DilloDayStyleKit notificationCellBackgroundColor];
    [self configureBarButtonItems];
    [self configureView];
    [self downloadSchedule];
}

- (void)configureBarButtonItems {
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(returnButtonTapped)];
    self.navigationItem.rightBarButtonItem = returnButton;
}

- (void)returnButtonTapped {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)configureView {
    [self.view addSubview:self.scrollView];
    //    [self.scrollView addSubview:self.imageView];
    [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.scrollView.backgroundColor = [UIColor clearColor];
}

- (void)configureMapImageView {
    self.imageView.image = self.image;
    [self.scrollView addSubview:self.imageView];
    [self.imageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView];
    [self.imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.imageView withMultiplier:self.image.size.height / self.image.size.width];

    self.scrollView.alpha = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.000001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        self.scrollView.zoomScale += 0.001;
        self.scrollView.alpha = 1;
    });
    //    [self.scrollView scaleToFit];
    //    CGPoint centerOffset = CGPointMake(0, 0);
    //    [self.scrollView setContentOffset: centerOffset animated: NO];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initForAutoLayout];
    }
    return _imageView;
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

- (void)downloadSchedule {
    UILabel *downloadLabel = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:downloadLabel];
    [downloadLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-50 relation:NSLayoutRelationLessThanOrEqual];
    downloadLabel.font = [UIFont boldFlatFontOfSize:50];
    downloadLabel.textColor = [DilloDayStyleKit fontColor];
    downloadLabel.adjustsFontSizeToFitWidth = YES;
    downloadLabel.minimumScaleFactor = 0.01;
    downloadLabel.numberOfLines = 1;
    downloadLabel.text = @"DOWNLOADING SCHEDULE";
    [downloadLabel sizeToFit];
    downloadLabel.textAlignment = NSTextAlignmentCenter;
    [downloadLabel autoCenterInSuperview];

    [self scheduleFetchPromise].then(^(DILPFShuttleSchedule *schedule){
        self.schedule = schedule;
        return [self scheduleFileDownloadPromise:schedule];
    }).then(^(NSData *mapImageData){
        self.image = [UIImage imageWithData:mapImageData];
        [self configureMapImageView];
    });

    [downloadLabel removeFromSuperview];
}

- (PMKPromise *)scheduleFetchPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        PFQuery *scheduleQuery = [DILPFShuttleSchedule query];
        [scheduleQuery whereKey:@"currentSchedule" equalTo:[NSNumber numberWithBool:YES]];
        [scheduleQuery findObjectsInBackgroundWithBlock:^(NSArray *PF_NULLABLE_S objects, NSError *PF_NULLABLE_S error) {
            if (objects) {
                fulfill([objects firstObject]);
            } else {
                reject(error);
            }
        }];
    }];
}

- (PMKPromise *)scheduleFileDownloadPromise:(DILPFShuttleSchedule *)schedule {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [schedule.shuttleScheduelImage getDataInBackgroundWithBlock:^(NSData *PF_NULLABLE_S data, NSError *PF_NULLABLE_S error){
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
    return self.imageView;
}

@end
