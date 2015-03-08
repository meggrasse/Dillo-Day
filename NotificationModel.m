//
//  NotificationModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "NotificationModel.h"

#define WEATHER_IMAGE [UIImage imageNamed:@"cloud394"]
#define WARNING_IMAGE [UIImage imageNamed:@"warning45"]
#define TIME_IMAGE [UIImage imageNamed:@"clock97"]
@interface NotificationModel()
@property (strong, nonatomic) NSMutableArray *notificationArray;
@end

@implementation NotificationModel
- (id)init {
    if (self = [super init]) {
        self.notificationArray = [NSMutableArray new];
        [self constructFakeDatabase];
    }
    
    return self;
}

- (void)constructFakeDatabase {
    [self.notificationArray addObject:[[Notification alloc] initWithMessage:@"Kid Cudi is playing at the Main Stage in 30 minutes!" image:TIME_IMAGE dateReceived:nil]];
    [self.notificationArray addObject:[[Notification alloc] initWithMessage:@"You won the Dillo Day photo contest! Come to the Mayfest stand in Norris to pick up your backstage passes to 50 Cent with a private performance of Temperature by Sean Paul!" image:WARNING_IMAGE dateReceived:nil]];
    [self.notificationArray addObject:[[Notification alloc] initWithMessage:@"Storms spotted in the area. Take shelter in Norris. Music will resume in 1 hour." image:WEATHER_IMAGE dateReceived:nil]];
    [self.notificationArray addObject:[[Notification alloc] initWithMessage:@"Congratulations! You have won a Dillo Day tee and free lunch and 3 friends!" image:WARNING_IMAGE dateReceived:nil]];
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return [self.notificationArray count];
}

- (Notification *)notificationForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (Notification *)self.notificationArray[indexPath.row];
}

@end
