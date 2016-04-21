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

@import MapKit;
@import CoreLocation;
@interface DILMapViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) MKMapView *mapView ;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) SMScrollView *scrollView;
@end

@implementation DILMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.locationManager.delegate = self;
    self.mapView.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    //check if they don't authorize
    self.mapView.showsUserLocation = YES;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    [self.view addSubview:self.mapView];
    CLLocationCoordinate2D midCoordinate = CLLocationCoordinate2DMake(42.055409, -87.671126);
    CLLocationCoordinate2D overlayTopLeftCoordinate = CLLocationCoordinate2DMake(42.055489, -87.671845);
    CLLocationCoordinate2D overlayTopRightCoordinate = CLLocationCoordinate2DMake(42.055759, -87.670525);
    CLLocationCoordinate2D overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(42.054994, -87.671566);
    CLLocationCoordinate2D overlayBottomRightCoordinate = CLLocationCoordinate2DMake(42.054930, -87.670418);
    MKMapRect overlayBoundingMapRect = MKMapRectMake(MKMapPointForCoordinate(overlayTopLeftCoordinate).x, MKMapPointForCoordinate(overlayTopLeftCoordinate).y, fabs(MKMapPointForCoordinate(overlayTopLeftCoordinate).x - MKMapPointForCoordinate(overlayTopRightCoordinate).x), fabs(MKMapPointForCoordinate(overlayTopLeftCoordinate).y - MKMapPointForCoordinate(overlayBottomLeftCoordinate).y));
    [self configureView];
}

- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations
{
    MKCoordinateRegion mapRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(42.054934, -87.671810), 500, 500);
    [self.mapView setRegion:mapRegion animated:NO];
}

- (void)configureView {
    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:self.imageView];
    [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.scrollView.backgroundColor = [UIColor clearColor];
}

//- (void)configureMapImageView {
//    [self.scrollView addSubview:self.mapImageView];
//    [self.mapImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView];
//    [self.mapImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.mapImageView withMultiplier:self.mapImage.size.height/self.mapImage.size.width];
//
//    self.scrollView.alpha = 0;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.000001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
//        self.scrollView.zoomScale += 0.001;
//        self.scrollView.alpha = 1;
//    });
////    [self.scrollView scaleToFit];
////    CGPoint centerOffset = CGPointMake(0, 0);
////    [self.scrollView setContentOffset: centerOffset animated: NO];
//}

//- (UIImageView *)mapImageView {
//    if (!_mapImageView) {
//        _mapImageView = [[UIImageView alloc] initForAutoLayout];
//    }
//    return _mapImageView;
//}
//
//- (SMScrollView *)scrollView {
//    if (!_scrollView) {
//        _scrollView = [[SMScrollView alloc] initForAutoLayout];
//        _scrollView.maximumZoomScale = 2.0;
//        _scrollView.minimumZoomScale = 1.0;
//        _scrollView.delegate = self;
//    }
//    return _scrollView;
//}
//
//- (void)downloadMap {
//    UILabel *downloadLabel = [[UILabel alloc] initForAutoLayout];
//    [self.view addSubview:downloadLabel];
//    [downloadLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-50 relation:NSLayoutRelationLessThanOrEqual];
//    downloadLabel.font = [UIFont boldFlatFontOfSize:50];
//    downloadLabel.textColor = [DilloDayStyleKit fontColor];
//    downloadLabel.adjustsFontSizeToFitWidth = YES;
//    downloadLabel.minimumScaleFactor = 0.01;
//    downloadLabel.numberOfLines = 1;
//    downloadLabel.text = @"DOWNLOADING MAP";
//    [downloadLabel sizeToFit];
//    downloadLabel.textAlignment = NSTextAlignmentCenter;
//    [downloadLabel autoCenterInSuperview];
//
//    [self mapFetchPromise].then(^(DILPFMap *map){
//        self.map = map;
//        return [self mapFileDownloadPromise:map];
//    }).then(^(NSData *mapImageData){
//        self.mapImage = [UIImage imageWithData:mapImageData];
//        [self configureMapImageView];
//    });
//
//    [downloadLabel removeFromSuperview];
//}
//
//- (PMKPromise *)mapFetchPromise {
//    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
//        PFQuery *mapQuery = [DILPFMap query];
//        [mapQuery whereKey:@"currentMap" equalTo:@(YES)];
//        //[mapQuery findObjectsInBackgroundWithBlock:^(NSArray *PF_NULLABLE_S objects, NSError *PF_NULLABLE_S error){
//        [mapQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
//            if (objects) {
//                fulfill([objects firstObject]);
//            } else {
//                reject(error);
//            }
//        }];
//    }];
//}
//
//- (PMKPromise *)mapFileDownloadPromise:(DILPFMap *)map {
//    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
//        //[map.mapFile getDataInBackgroundWithBlock:^(NSData *PF_NULLABLE_S data, NSError *PF_NULLABLE_S error){
//        [map.mapFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
//            if (data) {
//                fulfill(data);
//            } else {
//                reject(error);
//            }
//        }];
//    }];
//}
//
//#pragma mark - UIScrollViewDelegate
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return self.mapImageView;
//}

@end
