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

@import MapKit;
@import CoreLocation;
@interface DILMapViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) MKMapView *mapView ;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) SMScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonnull) NSMutableArray *annoArray;
@end

@implementation DILMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [[NSMutableArray alloc] init];
    self.annoArray = [[NSMutableArray alloc] init];
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
    CLLocationCoordinate2D diffCoordinate = CLLocationCoordinate2DMake(42.055409, -88.671126);
//    MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
//    anno.coordinate = midCoordinate;
//    anno.title = @"test";
//    anno.subtitle = @"secondtest";
    MKCircle *circle;
    circle = [MKCircle circleWithCenterCoordinate:midCoordinate radius:100];
    circle.title = @"here";
    circle.subtitle = @"here";
   // [self.mapView addOverlay:circle];
    [self.mapView addAnnotation:circle];
//    MKAnnotation ano = [[MKAnnotation alloc] init];
//    ano.coordinate = midCoordinate;
    
    //[self.mapView addAnnotation:anno];
    CLLocationCoordinate2D overlayTopLeftCoordinate = CLLocationCoordinate2DMake(42.055489, -87.671845);
    CLLocationCoordinate2D overlayTopRightCoordinate = CLLocationCoordinate2DMake(42.055759, -87.670525);
    CLLocationCoordinate2D overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(42.054994, -87.671566);
    CLLocationCoordinate2D overlayBottomRightCoordinate = CLLocationCoordinate2DMake(42.054930, -87.670418);
    MKMapRect overlayBoundingMapRect = MKMapRectMake(MKMapPointForCoordinate(overlayTopLeftCoordinate).x, MKMapPointForCoordinate(overlayTopLeftCoordinate).y, fabs(MKMapPointForCoordinate(overlayTopLeftCoordinate).x - MKMapPointForCoordinate(overlayTopRightCoordinate).x), fabs(MKMapPointForCoordinate(overlayTopLeftCoordinate).y - MKMapPointForCoordinate(overlayBottomLeftCoordinate).y));
    [self configureView];
}

// Delegate method from the MKMapViewDelegate protocol.
//-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
//    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
//    circleRenderer.fillColor =  [UIColor colorWithRed:0 green:0.647 blue:0.961 alpha:1.0];
//    return circleRenderer;
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *anno = [[MKAnnotationView alloc] initWithAnnotation: (id<MKAnnotation>)annotation reuseIdentifier:@"ehre"];
   // MKPinAnnotationView *annov = [[MKPinAnnotationView alloc]initWithAnnotation:annotation
                                          // reuseIdentifier:@"here"];
    anno.canShowCallout = YES;
    anno.image = [UIImage imageNamed:@"EXIT"];
    return anno;
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

//- (void) queryForPosts {
//    PFQuery *query = [PFQuery queryWithClassName:@"DILPFMapFeatures"];
//
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {  // The query failed
//            NSLog(@"error in geo query!");
//        } else {
//            for (PFObject *object in objects)   {
//                self.SpotNames.append(object["SpotName"] as String)
//                self.SpotGeoPoints.append(object["SpotLocation"] as PFGeoPoint)
//                self.SpotLocationLatitudes.append(self.SpotGeoPoints.last?.latitude as CLLocationDegrees!)
//                self.SpotLocationLongitudes.append(self.SpotGeoPoints.last?.longitude as CLLocationDegrees!)
//                
//                var annotation = MKPointAnnotation()
//                annotation.coordinate = CLLocationCoordinate2DMake(self.SpotLocationLatitudes.last!, self.SpotLocationLongitudes.last!)
//                annotation.title = self.SpotNames.last!
//                self.mainMap.addAnnotation(annotation)
//                self.mainMap.showsUserLocation = true
//            // The query is successful
//            // 1. Find new posts (those that we did not already have)
//            // 2. Find posts to remove (those we have but that we did not get from this query)
//            // 3. Configure the new posts
//            // 4. Remove the old posts and add the new posts
//        }
//    }];

    // Create a PFQuery asking for all wall posts 100km of the user
    // We won't be showing all of the posts returned, 100km is our buffer
//    [query whereKey:PAWParsePostLocationKey
//       nearGeoPoint:point
//        withinKilometers:PAWWallPostMaximumSearchDistance];
//
//    // Include the associated PFUser objects in the returned data
//    [query includeKey:PAWParsePostUserKey];
//
//    // Limit the number of wall posts returned to 20
//    query.limit = PAWWallPostsSearchDefaultLimit;
//}

//-(UIImage *) getImage {
//    PFQuery *query = [PFQuery queryWithClassName:@"DILPFMapFeatures"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            for (PFObject *object in objects) {
//            PFFile *file = [object objectForKey:@"image"];
//            imageHolder.file = file;
//            [imageHolder loadInBackground];
//        }
//    }
//
//}

-(void) getImage {
    PFQuery *query = [PFQuery queryWithClassName:@"DILPFMapFeatures"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                PFFile *file = [object objectForKey:@"image"];
                [file getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:imageData];
                        [self.imageArray addObject:image];
                    }
                }];
            }
        }
    }];
}

-(void) queryForPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"DILPFMapFeatures"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
                anno.title = [object objectForKey:@"title"];
                anno.subtitle = [object objectForKey:@"subtitle"];
                PFGeoPoint *gp = [object objectForKey:@"location"];
                CLLocationCoordinate2D *temp;
                temp->latitude = gp.latitude;
                temp->longitude = gp.longitude;
//                CLLocationDegrees lat = 40;
//                CLLocationDegrees lon = gp.longitude;
//                CLLocationCoordinate2D *temp = CLLocationCoordinate2DMake(lat, lon);
                anno.coordinate = *(temp);
                [self.mapView addAnnotation:anno];
            }
        }
    }];
}


    
@end
