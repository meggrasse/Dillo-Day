//
//  DILNotification.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/10/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILNotification.h"
#import "DILPushNotificationHandler.h"

@implementation DILNotification
+ (NSString *)primaryKey {
    return @"objectId";
}

- (void)markRead {
    if (self.unread) {
        RLMRealm *notificationRealm = [[DILPushNotificationHandler sharedPushNotificationHandler] notificationRealm];
        [notificationRealm beginWriteTransaction];
        self.unread = NO;
        NSInteger numberOfBadges = [UIApplication sharedApplication].applicationIconBadgeNumber;
        numberOfBadges--;
        if (numberOfBadges < 0) {
            numberOfBadges = 0;
        }
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:numberOfBadges];
        [notificationRealm commitWriteTransaction];
    }
}

- (BOOL)addToDatabase {
    RLMRealm *notificationRealm = [[DILPushNotificationHandler sharedPushNotificationHandler] notificationRealm];
    if (![DILNotification objectInRealm:notificationRealm forPrimaryKey:self.objectId]) {
        [notificationRealm beginWriteTransaction];
        [notificationRealm addObject:self];
        [notificationRealm commitWriteTransaction];
        return YES;
    } else {
        return NO;
    }
}

+ (DILNotification *)notificationFromPFNotification:(PFNotification *)notification {
    DILNotification *newAPN = [DILNotification new];
    newAPN.alert = notification.alert;
    newAPN.dateRecieved = [NSDate dateWithTimeIntervalSince1970:[notification.time floatValue]];
    newAPN.dateRecieved = notification.createdAt;
    newAPN.unread = YES;
    newAPN.objectId = notification.objectId;
    newAPN.createdAt = notification.createdAt;
    return newAPN;
}
@end
