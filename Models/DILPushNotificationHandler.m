//
//  DILPushNotificationHandler.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/10/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPushNotificationHandler.h"
#import "DILNotification.h"
#import "PFNotification.h"

NSString *kDILPushNotificationHandlerRecievedNewNotificationKey = @"kDILPushNotificationHandlerRecievedNewNotificationKey";

static NSString *const kDILPushNotificationHandlerUserInfoAPSAlertKey = @"aps";
static NSString *const kDILPushNotificationHandlerAPSAlertKey = @"alert";
static NSString *const kDILPushNotificationHandlerUserInfoTitleKey = @"title";
static NSString *const kDILPushNotificationHandlerUserInfoTimeKey = @"time";

@implementation DILPushNotificationHandler
+ (instancetype)sharedPushNotificationHandler {
    static DILPushNotificationHandler *_sharedPushNotificationHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPushNotificationHandler = [DILPushNotificationHandler new];
        [_sharedPushNotificationHandler removeFileProtectionKeys];
    });
    
    return _sharedPushNotificationHandler;
}

- (void)handlePushNotification:(NSDictionary *)userInfo {
    NSDictionary *apsDictionary = userInfo[kDILPushNotificationHandlerUserInfoAPSAlertKey];
    NSString *alertText = apsDictionary[kDILPushNotificationHandlerAPSAlertKey];

    NSDate *alertDate = [NSDate dateWithTimeIntervalSince1970:[(NSString *)userInfo[kDILPushNotificationHandlerUserInfoTimeKey] floatValue]];

    DILNotification *newNotification = [DILNotification new];
    newNotification.alert = alertText;
    newNotification.dateRecieved = alertDate;
    newNotification.unread = YES;

    [[self notificationRealm] beginWriteTransaction];
    [[self notificationRealm] addObject:newNotification];
    [[self notificationRealm] commitWriteTransaction];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDILPushNotificationHandlerRecievedNewNotificationKey object:newNotification];
}

- (void)fetchNewNotificationsWithFetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [PFNotification recentNotificationsFetchPromise].then(^(NSArray *objects){
        BOOL sendNotification = NO;
        for (PFNotification *pfNotification in objects) {
            DILNotification *newAPN = [DILNotification notificationFromPFNotification:pfNotification];
            sendNotification = sendNotification || [newAPN addToDatabase];
        }
        
        if (sendNotification) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kDILPushNotificationHandlerRecievedNewNotificationKey object:nil];
        }

        if (completionHandler) {
            completionHandler(UIBackgroundFetchResultNewData);
        }
    }).catch(^(NSError *error){
        if (completionHandler) {
            completionHandler(UIBackgroundFetchResultFailed);
        }
    });
}

- (RLMRealm *)notificationRealm {
    return [RLMRealm defaultRealm];
}

- (void)removeFileProtectionKeys {
    RLMRealm *notificationRealm = [self notificationRealm];
    NSString *pathToRealmFile = [notificationRealm path];
    NSLog(@"%@", pathToRealmFile);
    NSArray *allNotificationRealmRelatedFiles = @[
                                                  pathToRealmFile,
                                                  [pathToRealmFile stringByAppendingPathComponent:@".lock"],
                                                  [pathToRealmFile stringByAppendingPathComponent:@".log"],
                                                  [pathToRealmFile stringByAppendingPathComponent:@".log_a"],
                                                  [pathToRealmFile stringByAppendingPathComponent:@".log_b"]
                                                  ];

    for (NSString *path in allNotificationRealmRelatedFiles) {
        NSError *error = nil;
        [[NSFileManager defaultManager] setAttributes:@{NSFileProtectionKey: NSFileProtectionNone}
                                         ofItemAtPath:path
                                                error:&error];
    }

}

- (void)updateNotificationBadgeNumber {
    RLMResults *unreadNotifications = [DILNotification objectsInRealm:[self notificationRealm] where:@"unread == YES"];
    NSUInteger unreadCount = unreadNotifications.count;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unreadCount];
}
@end
