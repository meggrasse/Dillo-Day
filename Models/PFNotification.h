//
//  PFNotification.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/5/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import <PromiseKit/PromiseKit.h>

@interface PFNotification : PFObject<PFSubclassing>
@property (retain) NSString *badge;
@property (retain) NSString *time;
@property (retain) NSString *alert;

+ (PMKPromise *)recentNotificationsFetchPromise;
@end
