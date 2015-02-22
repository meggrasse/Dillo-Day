//
//  MapCSViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "MapCSViewController.h"
#import <Mapbox-iOS-SDK/Mapbox.h>

#define DEFAULT_SECRET_TOKEN @"sk.eyJ1IjoiZmVlbG15ZWFycyIsImEiOiJoTG43cnNrIn0.ORx583lvFvM9sowP4vVjdg"
#define DEFAULT_PUBLIC_TOKEN @"pk.eyJ1IjoiZmVlbG15ZWFycyIsImEiOiJMSXVaMk44In0.EO8ZPT4CPshZ1Z5MDQtq6w"
#define DILLO_MAP_TOKEN @"feelmyears.l6h50o0p"

@interface MapCSViewController ()
@property (strong, nonatomic) RMMapView *mapView;
@property (strong, nonatomic) RMMapboxSource *mapSource;
@end

@implementation MapCSViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray * controllerArray = [[self navigationController] viewControllers];
    
    for (UIViewController *controller in controllerArray){
        //Code here.. e.g. print their titles to see the array setup;
        NSLog(@"%@",controller.title);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"map";
    [self configureMap];
    [self configureDilloButtonToUnwindOnTap:YES];
}

- (void)configureMap {
    [[RMConfiguration sharedInstance] setAccessToken:DEFAULT_SECRET_TOKEN];
    self.mapSource = [[RMMapboxSource alloc] initWithMapID:DILLO_MAP_TOKEN];
    self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds];
    [self.mapView addTileSource:self.mapSource];
    CLLocationCoordinate2D lakeFillCoordinate = CLLocationCoordinate2DMake(42.055289, -87.670851);
    [self.mapView setZoom:16 atCoordinate:lakeFillCoordinate animated:NO];
    [self.mapView setMinZoom:14.5];
    [self.mapView setConstraintsSouthWest:CLLocationCoordinate2DMake(42.042853, -87.690017) northEast:CLLocationCoordinate2DMake(42.061399, -87.662809)];
    [self.view addSubview:self.mapView];
}
@end
