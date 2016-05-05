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
#import "DILPFMapFeatures.h"
#import <Parse/Parse.h>
#import <SVProgressHUD/SVProgressHUD.h>

@import MapKit;
@import CoreLocation;
@interface DILMapViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) MKMapView *mapView ;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) SMScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonnull) NSArray *annoArray;
@property (strong, nonnull) PFFile *currFile;
@property (strong, nonnull) NSMutableArray *imageFileArray;
@property (strong, nonnull) MKAnnotationView *annoView;
@property (strong, nonnull) NSMutableArray *realAnnoArray;
@end

@implementation DILMapViewController

int currIndex = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [[NSMutableArray alloc] init];
    self.annoArray = [[NSMutableArray alloc] init];
    self.imageFileArray = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.realAnnoArray = [[NSMutableArray alloc] init];
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
    [self fetchAnnotations];
    [self configureView];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annoView = [[MKAnnotationView alloc] initWithAnnotation: (id<MKAnnotation>)annotation reuseIdentifier:nil];
    annoView.canShowCallout = YES;
    annoView.image = self.imageArray[currIndex];
    currIndex++;
    return annoView;
}

- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations
{
    MKCoordinateRegion mapRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(42.054934, -87.671810), 500, 500);
    [self.mapView setRegion:mapRegion animated:NO];
}

- (void)configureView {
    [self.view addSubview:self.scrollView];
    [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.scrollView.backgroundColor = [UIColor clearColor];
}

- (PMKPromise *)annotationQueryPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        PFQuery *mapQuery = [DILPFMapFeatures query];
        [mapQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                reject(error);
            } else {
                fulfill(objects);
            }
        }];
    }];
}

- (PMKPromise *)imageQueryPromise: (PFFile *)imageFile {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (error) {
                reject(error);
            } else {
                UIImage *image = [UIImage imageWithData:data];
                [self.imageArray addObject:image];
                fulfill(image);
            }
        }];
    }];
}

- (void)fetchAnnotations {
    [SVProgressHUD show];
    [self annotationQueryPromise].then(^(NSArray *annotations) {
        [SVProgressHUD dismiss];
        self.annoArray = annotations;
        [self fillAnnotations];
    });
}

-(void) fillAnnotations {
    for (DILPFMapFeatures *anno in self.annoArray) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.title = [anno objectForKey:@"title"];
        annotation.subtitle = [anno objectForKey:@"subtitle"];
        PFFile *tempFile = [anno objectForKey:@"image"];
        [self.imageFileArray addObject:tempFile];
        PFGeoPoint *gp = [anno objectForKey:@"coordinate"];
        CLLocationCoordinate2D temp = CLLocationCoordinate2DMake(gp.latitude, gp.longitude);
        annotation.coordinate = temp;
        [self.realAnnoArray addObject:annotation];
    }
    [self setImagetoAnno];
}

-(void) setImagetoAnno {
    for (PFFile *file in self.imageFileArray) {
        [self imageQueryPromise:file].then(^{
            for (MKPointAnnotation *anno in self.realAnnoArray) {
                [self.mapView addAnnotation:anno];
            }
        });
    }
}



@end
