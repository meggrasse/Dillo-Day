//
//  DILPushNotificationHandler.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/10/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

extern NSString *kDILPushNotificationHandlerRecievedNewNotificationKey;

@interface DILPushNotificationHandler : NSObject
+ (id)sharedPushNotificationHandler;
- (void)handlePushNotification:(NSDictionary *)userInfo;
- (RLMRealm *)notificationRealm;
- (void)fetchNewNotificationsWithFetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)updateNotificationBadgeNumber;
@end
