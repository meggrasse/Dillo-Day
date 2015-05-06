//
//  DILNotification.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/10/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "PFNotification.h"

@interface DILNotification : RLMObject
@property NSString *alert;
@property NSDate *dateRecieved;
@property NSString *objectId;
@property NSDate *createdAt;
@property BOOL unread;

+ (NSString *)primaryKey;
- (void)markRead;
+ (DILNotification *)notificationFromPFNotification:(PFNotification *)notification;
- (BOOL)addToDatabase;
@end
