//
//  PFNotification.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/5/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "PFNotification.h"

@implementation PFNotification
@dynamic time;
@dynamic alert;
@dynamic badge;

+ (NSString *)parseClassName {
    return NSStringFromClass([self class]);
}

+ (void)load {
    [self registerSubclass];
}

+ (PMKPromise *)recentNotificationsFetchPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        if ([PFInstallation currentInstallation].createdAt) {
            PFQuery *recentNotificationsQuery = [PFNotification query];
            [recentNotificationsQuery whereKey:@"createdAt" greaterThan:[PFInstallation currentInstallation].createdAt];
            [recentNotificationsQuery orderByDescending:@"createdAt"];
            [recentNotificationsQuery findObjectsInBackgroundWithBlock:^(NSArray *PF_NULLABLE_S objects,  NSError *PF_NULLABLE_S error){
                if (objects) {
                    fulfill(objects);
                } else {
                    reject(error);
                }
            }];
        } else {
            reject([NSError new]);
        }
    }];
}
@end
