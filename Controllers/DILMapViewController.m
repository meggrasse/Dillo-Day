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
@property (strong, nonnull) UIImage *currImage;
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
//    CLLocationCoordinate2D midCoordinate = CLLocationCoordinate2DMake(42.055409, -87.671126);
//    CLLocationCoordinate2D diffCoordinate = CLLocationCoordinate2DMake(42.055409, -88.671126);
//    MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
//    anno.coordinate = midCoordinate;
//    anno.title = @"test";
//    anno.subtitle = @"secondtest";
//    MKCircle *circle;
//    circle = [MKCircle circleWithCenterCoordinate:midCoordinate radius:100];
//    circle.title = @"here";
//    circle.subtitle = @"here";
   // [self.mapView addOverlay:circle];
//    [self.mapView addAnnotation:circle];
//    MKAnnotation ano = [[MKAnnotation alloc] init];
//    ano.coordinate = midCoordinate;
//    [self queryForAnnotations];
//    [self getImages];
//    [self fillAnnotations];
   // NSLog(@"this one %@", anno);
   // [self.mapView addAnnotation:anno];
    [self fetchAnnotations];
    [self configureView];
}

// Delegate method from the MKMapViewDelegate protocol.
//-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
//    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
//    circleRenderer.fillColor =  [UIColor colorWithRed:0 green:0.647 blue:0.961 alpha:1.0];
//    return circleRenderer;
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    NSLog(@"here1.5");
    
    //self.annoView = [[MKAnnotationView alloc] initWithAnnotation: (id<MKAnnotation>)annotation reuseIdentifier:nil];
    MKAnnotationView *annoView = [[MKAnnotationView alloc] initWithAnnotation: (id<MKAnnotation>)annotation reuseIdentifier:nil];
//    for (PFFile *file in self.imageFileArray) {
//        [self imageQueryPromise:file].then(^{
            annoView.canShowCallout = YES;
    NSLog(@"%@", self.imageArray[currIndex]);
            annoView.image = self.imageArray[currIndex];
            currIndex++;
            //NSLog(@"%@", annoView);
            //NSLog(@"fjdksla");
            return annoView;
       // }).catch(^{
//            return self.annoView;
//        });
//    }
//    return self.annoView;
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
                self.currImage = image;
                [self.imageArray addObject:image];
                //self.annoView.image = image;
                NSLog(@"%@", self.imageArray);
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

//-(void)fillImageArray {
//    for (DILPFMapFeatures *anno in self.annoArray) {
//        PFFile *imageFile = [anno objectForKey:@"image"];
//        [self imageQueryPromise:imageFile];
//        [self imageQueryPromise:imageFile complete:^{
//            NSLog(@"here");
//        }];
//    }
//
//}
//
//- (PMKPromise *)getImages {
//    return [PMKPromise promiseWithResolverBlock:^(PMKResolver *resolve) {
//        PFQuery *query = [PFUser query];
//        [query whereKey:@"name" equals:@"mxcl"];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            resolve(error ?: objects);
//        }];
//    }];
//}
//
//- (PMKPromise *)users {
//    return [PMKPromise promiseWithResolverBlock:^(PMKResolver *resolve) {
//        PFQuery *query = [PFUser query];
//        [query whereKey:@"name" equals:@"mxcl"];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            resolve(error ?: objects);
//        }];
//    }];
//}
//
//[self users].then(^(NSArray *users){
//    //…
//});

//-(void)fillImageArray {
//    for (DILPFMapFeatures *anno in self.annoArray) {
//        PFFile *imageFile = [anno objectForKey:@"image"];
//        [self sendFiletoPromise:imageFile];
//    }
//    
//}
//
//-(void)sendFiletoPromise:(PFFile *) imageFile {
//    [self imageQueryPromise:imageFile].then(^(UIImage *image) {
//        [self.imageArray addObject:image];
//    });
//    NSLog(@"%@", self.imageArray);
//}

//-(void) fillAnnotations {
//    if (currIndex >= [_annoArray count]) {
//        return;
//    }
//    //for (DILPFMapFeatures *anno in _annoArray) {
//    DILPFMapFeatures *anno = _annoArray[1];
//        NSLog(@"here");
//        PFFile *imageFile = [anno objectForKey:@"image"];
//        PMKWhen([self imageQueryPromise:imageFile]).then(^(NSArray *results) {
//            [self.imageArray addObject:image];
//            NSLog(@"%lu", (unsigned long)[self.imageArray count]);
//            NSLog(@"%@", self.imageArray);
//            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//            annotation.title = [anno objectForKey:@"title"];
//            annotation.subtitle = [anno objectForKey:@"subtitle"];
//            PFGeoPoint *gp = [anno objectForKey:@"location"];
//            CLLocationCoordinate2D *temp;
//            temp->latitude = gp.latitude;
//            temp->longitude = gp.longitude;
//            annotation.coordinate = *(temp);
//            [self.mapView addAnnotation:annotation];
//            currIndex++;
//        });
//    //}
//}


-(void) fillAnnotations {
    for (DILPFMapFeatures *anno in self.annoArray) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.title = [anno objectForKey:@"title"];
        annotation.subtitle = [anno objectForKey:@"subtitle"];
        PFFile *tempFile = [anno objectForKey:@"image"];
        [self.imageFileArray addObject:tempFile];
        PFGeoPoint *gp = [anno objectForKey:@"coordinate"];
        CLLocationCoordinate2D temp = CLLocationCoordinate2DMake(gp.latitude, gp.longitude);
        //CLLocationCoordinate2D temp = CLLocationCoordinate2DMake(42.055409, -87.671126);
        annotation.coordinate = temp;
        NSLog(@"2nd one %@", annotation);
        [self.realAnnoArray addObject:annotation];
        NSLog(@"3nd one %@", self.realAnnoArray);
        //[self.mapView addAnnotation:annotation];
    }
    [self setImagetoAnno];
}
-(void) setImagetoAnno {
    for (PFFile *file in self.imageFileArray) {
        [self imageQueryPromise:file].then(^{
            [self sendDatatoAnno];
        });
    }
}

-(void) sendDatatoAnno {
    for (MKPointAnnotation *anno in self.realAnnoArray) {
        [self.mapView addAnnotation:anno];
    }
}




@end
