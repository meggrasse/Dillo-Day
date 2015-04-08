//
//  AppDelegate.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/8/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <RDVTabBarController/RDVTabBarController.h>

#import "DILLineupViewController.h"
#import "DILSwipeLineupViewController.h"
#import "MapViewController.h"
#import "HelpViewController.h"
#import "DILNotificationsViewController.h"
#import "DILFakeDataGenerator.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"zpDqUtE6y2RIcuWeUPwKPUJYZi12qal1vF83n2GF"
                  clientKey:@"LDaDgElWPLhahqdw3MjYlouCWFzHzewaxHWYvEgb"];

//    [[DILFakeDataGenerator new] generateData];

    DILLineupViewController *lineupVC = [DILLineupViewController new];
    lineupVC.title = @"Lineup";
    UINavigationController *lineupNavController = [[UINavigationController alloc] initWithRootViewController:lineupVC];

    DILSwipeLineupViewController *swipeLineupVC = [DILSwipeLineupViewController new];
    swipeLineupVC.title = @"Lineup";
    UINavigationController *swipeLineupNavController = [[UINavigationController alloc] initWithRootViewController:swipeLineupVC];
    
    MapViewController *mapVC = [[MapViewController alloc] init];
    mapVC.title = @"Map";
    UINavigationController *mapNavController = [[UINavigationController alloc] initWithRootViewController:mapVC];


    DILNotificationsViewController *notificationVC = [[DILNotificationsViewController alloc] init];
    notificationVC.title = @"Notifications";
    UINavigationController *notificationsNavController = [[UINavigationController alloc] initWithRootViewController:notificationVC];


    HelpViewController *helpVC = [HelpViewController new];
    helpVC.title = @"Emergency";
    UINavigationController *helpNavController = [[UINavigationController alloc] initWithRootViewController:helpVC];
    
    NSArray *navigationControllerArray = @[lineupNavController, swipeLineupNavController, mapNavController, notificationsNavController, helpNavController];
    for (UINavigationController *controller in navigationControllerArray) {
        [self configureFlatNavigationController:controller];
    }

//    [UIBarButtonItem configureFlatButtonsWithColor:[DilloDayStyleKit barButtonItemColor] highlightedColor:[DilloDayStyleKit barButtonItemHighlightedColor] cornerRadius:3];

    UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    UITabBar *tabBar = tabBarController.tabBar;
    tabBar.tintColor = [UIColor whiteColor];
    [tabBarController setViewControllers:navigationControllerArray];
    [tabBar configureFlatTabBarWithColor:[DilloDayStyleKit tabBarColor]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)configureFlatNavigationController:(UINavigationController *)controller {
    UINavigationBar *navigationBar = controller.navigationBar;
    [navigationBar configureFlatNavigationBarWithColor:[DilloDayStyleKit navigationBarColor]];
    navigationBar.tintColor = [UIColor whiteColor];
}

@end
