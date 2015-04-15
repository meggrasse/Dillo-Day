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
#import <RDVTabBarController/RDVTabBarItem.h>

#import "DILLineupViewController.h"
#import "DILSwipeLineupViewController.h"
#import "MapViewController.h"
#import "DILHelpViewController.h"
#import "DILNotificationsViewController.h"
#import "DILFakeDataGenerator.h"
#import "DILParseClassGeneration.h"
#import "DILPushNotificationHandler.h"

@interface AppDelegate ()
@property (strong, nonatomic) RDVTabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"zpDqUtE6y2RIcuWeUPwKPUJYZi12qal1vF83n2GF"
                  clientKey:@"LDaDgElWPLhahqdw3MjYlouCWFzHzewaxHWYvEgb"];



    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes

                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];

//    [[DILFakeDataGenerator new] generateData];
//    [DILParseClassGeneration createAllRoles];

    DILLineupViewController *lineupVC = [DILLineupViewController new];
    lineupVC.title = @"Lineup";
    UINavigationController *lineupNavController = [[UINavigationController alloc] initWithRootViewController:lineupVC];

    MapViewController *mapVC = [[MapViewController alloc] init];
    mapVC.title = @"Map";
    UINavigationController *mapNavController = [[UINavigationController alloc] initWithRootViewController:mapVC];


    DILNotificationsViewController *notificationVC = [[DILNotificationsViewController alloc] init];
    notificationVC.title = @"Notifications";
    UINavigationController *notificationsNavController = [[UINavigationController alloc] initWithRootViewController:notificationVC];


    DILHelpViewController *helpVC = [DILHelpViewController new];
    helpVC.title = @"Help";
    UINavigationController *helpNavController = [[UINavigationController alloc] initWithRootViewController:helpVC];
    
    NSArray *navigationControllerArray = @[lineupNavController, mapNavController, notificationsNavController, helpNavController];


    for (UINavigationController *controller in navigationControllerArray) {
        [self configureFlatNavigationController:controller];
    }

//    [UIBarButtonItem configureFlatButtonsWithColor:[DilloDayStyleKit barButtonItemColor] highlightedColor:[DilloDayStyleKit barButtonItemHighlightedColor] cornerRadius:3];

    self.tabBarController = [[RDVTabBarController alloc] initWithNibName:nil bundle:nil];
    RDVTabBar *tabBar = self.tabBarController.tabBar;
    tabBar.backgroundView.backgroundColor = [DilloDayStyleKit tabBarColor];
    [self.tabBarController setViewControllers:navigationControllerArray];

    NSArray *selectedIconArray = @[[UIImage imageNamed:@"Lineup (Selected)"],
                                   [UIImage imageNamed:@"Map (Selected)"],
                                   [UIImage imageNamed:@"Notifications (Selected)"],
                                   [UIImage imageNamed:@"Help (Selected)"]];

    NSArray *unselectedIconArray = @[[UIImage imageNamed:@"Lineup (Unselected)"],
                                   [UIImage imageNamed:@"Map (Unselected)"],
                                   [UIImage imageNamed:@"Notifications (Unselected)"],
                                   [UIImage imageNamed:@"Help (Unselected)"]];

    for (int i = 0; i < self.tabBarController.tabBar.items.count; i++) {
        RDVTabBarItem *tabBarItem = (RDVTabBarItem *)self.tabBarController.tabBar.items[i];
        [tabBarItem setTitle:nil];
        [tabBarItem setFinishedSelectedImage:selectedIconArray[i] withFinishedUnselectedImage:unselectedIconArray[i]];
    }

    [self.tabBarController.tabBar setBackgroundColor:[UIColor turquoiseColor]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)configureFlatNavigationController:(UINavigationController *)controller {
    UINavigationBar *navigationBar = controller.navigationBar;
    [navigationBar configureFlatNavigationBarWithColor:[DilloDayStyleKit navigationBarColor]];
    navigationBar.tintColor = [UIColor whiteColor];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (![UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        NSUInteger indexOfNotificationsVC = [self.tabBarController.viewControllers indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isMemberOfClass:[UINavigationController class]]) {
                UIViewController *viewController = [((UINavigationController *)obj).viewControllers firstObject];
                if ([viewController isMemberOfClass:[DILNotificationsViewController class]]) {
                    return YES;
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        }];

        [self.tabBarController setSelectedIndex:indexOfNotificationsVC];
    }
    [[DILPushNotificationHandler sharedPushNotificationHandler] handlePushNotification:userInfo[@"aps"]];
}
@end
