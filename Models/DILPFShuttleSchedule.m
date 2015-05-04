//
//  DILPFShuttleSchedule.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPFShuttleSchedule.h"

@implementation DILPFShuttleSchedule
@dynamic scheduleName;
@dynamic shuttleScheduelImage;
@dynamic currentSchedule;

+ (NSString *)parseClassName {
    return NSStringFromClass([self class]);
}

+ (void)load {
    [self registerSubclass];
}
@end
