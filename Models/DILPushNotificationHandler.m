//
//  DILPushNotificationHandler.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/10/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPushNotificationHandler.h"
#import "DILNotification.h"

NSString *kDILPushNotificationHandlerRecievedNewNotificationKey = @"kDILPushNotificationHandlerRecievedNewNotificationKey";

static NSString *const kDILPushNotificationHandlerAlertKey = @"alert";

@implementation DILPushNotificationHandler
+ (instancetype)sharedPushNotificationHandler {
    static DILPushNotificationHandler *_sharedPushNotificationHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPushNotificationHandler = [DILPushNotificationHandler new];
    });
    
    return _sharedPushNotificationHandler;
}

- (void)handlePushNotification:(NSDictionary *)userInfo {
    NSString *alertText = userInfo[kDILPushNotificationHandlerAlertKey];

    DILNotification *newNotification = [DILNotification new];
    newNotification.alert = alertText;
    newNotification.dateRecieved = [NSDate date];
    newNotification.unread = YES;

    [[self notificationRealm] beginWriteTransaction];
    [[self notificationRealm] addObject:newNotification];
    [[self notificationRealm] commitWriteTransaction];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDILPushNotificationHandlerRecievedNewNotificationKey object:newNotification];
}

- (RLMRealm *)notificationRealm {
    return [RLMRealm defaultRealm];
}
@end
