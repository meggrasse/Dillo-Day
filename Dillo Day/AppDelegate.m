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
#import <SVProgressHUD/SVProgressHUD.h>
#import <Spotify/Spotify.h>
#import <AVFoundation/AVFoundation.h>

#import "DILLineupViewController.h"
#import "DILMapViewController.h"
#import "DILHelpViewController.h"
#import "DILNotificationsViewController.h"
#import "DILFakeDataGenerator.h"
#import "DILParseClassGeneration.h"
#import "DILPushNotificationHandler.h"


@interface AppDelegate ()
@property (strong, nonatomic) RDVTabBarController *tabBarController;
@property (nonatomic, strong) SPTSession *session;
@property (nonatomic, strong) SPTAudioStreamingController *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"27yFuFV8nW6mRudOABtjzkOSdoYY9krMdmhoJcgc";
        configuration.server = @"http://mayfest-db.herokuapp.com/parse";
    }]];

    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];


    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:18]];
    [SVProgressHUD setBackgroundColor:[DilloDayStyleKit notificationCellBackgroundColor]];


    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];


    DILLineupViewController *lineupVC = [DILLineupViewController new];
    UINavigationController *lineupNavController = [[UINavigationController alloc] initWithRootViewController:lineupVC];

    DILMapViewController *mapVC = [[DILMapViewController alloc] init];
    mapVC.title = @"MAP";
    UINavigationController *mapNavController = [[UINavigationController alloc] initWithRootViewController:mapVC];


    DILNotificationsViewController *notificationVC = [[DILNotificationsViewController alloc] init];
    notificationVC.title = @"ALERTS";
    UINavigationController *notificationsNavController = [[UINavigationController alloc] initWithRootViewController:notificationVC];


    DILHelpViewController *helpVC = [DILHelpViewController new];
    helpVC.title = @"INFO";
    UINavigationController *helpNavController = [[UINavigationController alloc] initWithRootViewController:helpVC];
    
    NSArray *navigationControllerArray = @[lineupNavController, mapNavController, notificationsNavController, helpNavController];


    for (UINavigationController *controller in navigationControllerArray) {
        [self configureFlatNavigationController:controller];
    }


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

    [self.tabBarController.tabBar setBackgroundColor:[UIColor colorWithRed: 0.929 green: 0.224 blue: 0.588 alpha: 1]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [[SPTAuth defaultInstance] setClientID:@"607cdff95f51464bad31c3e314af0832"];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"23f7504f730848dbbe71c252ad36c3d6"]];
    [[SPTAuth defaultInstance] setRequestedScopes:@[SPTAuthStreamingScope]];

//    [[DILPushNotificationHandler sharedPushNotificationHandler] updateNotificationBadgeNumber];

    return YES;
}

- (void)configureFlatNavigationController:(UINavigationController *)controller {
    UINavigationBar *navigationBar = controller.navigationBar;
    navigationBar.tintColor = [DilloDayStyleKit navigationBarTextColor];
    navigationBar.translucent = NO;
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
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[DILPushNotificationHandler sharedPushNotificationHandler] fetchNewNotificationsWithFetchCompletionHandler:completionHandler];
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
    } else {
        NSDictionary *apsDictionary = userInfo[@"aps"];
        NSString *apsAlertText = apsDictionary[@"alert"];
        [SVProgressHUD showInfoWithStatus:apsAlertText];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
//    [[DILPushNotificationHandler sharedPushNotificationHandler] updateNotificationBadgeNumber];
}

@end
