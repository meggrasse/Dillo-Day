//
//  MapViewController.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/26/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "MapViewController.h"
#import <MapBox-iOS-SDK/Mapbox.h>

#define DEFAULT_SECRET_TOKEN @"sk.eyJ1IjoiZmVlbG15ZWFycyIsImEiOiJoTG43cnNrIn0.ORx583lvFvM9sowP4vVjdg"
#define DEFAULT_PUBLIC_TOKEN @"pk.eyJ1IjoiZmVlbG15ZWFycyIsImEiOiJMSXVaMk44In0.EO8ZPT4CPshZ1Z5MDQtq6w"
#define DILLO_MAP_TOKEN @"feelmyears.l6h50o0p"

@interface MapViewController ()
@property (strong, nonatomic) RMMapView *mapView;
@property (strong, nonatomic) RMMapboxSource *mapSource;
@end

@implementation MapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_mapView) {
        [self configureMap];
    }
}

- (void)configureMap {
    [[RMConfiguration sharedInstance] setAccessToken:DEFAULT_SECRET_TOKEN];
    self.mapSource = [[RMMapboxSource alloc] initWithMapID:DILLO_MAP_TOKEN];
    self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    
    [self.mapView addTileSource:self.mapSource];
    CLLocationCoordinate2D lakeFillCoordinate = CLLocationCoordinate2DMake(42.055289, -87.670851);
    [self.mapView setZoom:16 atCoordinate:lakeFillCoordinate animated:NO];
    [self.mapView setMinZoom:14.5];
    [self.mapView setConstraintsSouthWest:CLLocationCoordinate2DMake(42.042853, -87.690017) northEast:CLLocationCoordinate2DMake(42.061399, -87.662809)];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
