//
//  DILPFShuttleSchedule.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@interface DILPFShuttleSchedule : PFObject<PFSubclassing>
@property (retain) PFFile *shuttleScheduelImage;
@property (retain) NSString *scheduleName;
@property (retain) NSNumber *currentSchedule;
@end
