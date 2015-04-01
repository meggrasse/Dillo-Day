//
//  DILNotificationsTableViewModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILNotificationsTableViewModel.h"
#import "Notification.h"
#import "DILNotificationHTKTableViewCell.h"

#define WEATHER_IMAGE [UIImage imageNamed:@"cloud394"]
#define WARNING_IMAGE [UIImage imageNamed:@"warning45"]
#define TIME_IMAGE [UIImage imageNamed:@"clock97"]

@interface DILNotificationsTableViewModel()
@property (strong, nonatomic) NSMutableArray *notificationArray;
@property BOOL hasRegisteredCell;
@end

@implementation DILNotificationsTableViewModel
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notificationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DILNotificationHTKTableViewCellIdentifier = @"DILNotificationHTKTableViewCellIdentifier";
    if (!self.hasRegisteredCell) {
        [tableView registerClass:[DILNotificationHTKTableViewCell class] forCellReuseIdentifier:DILNotificationHTKTableViewCellIdentifier];
        self.hasRegisteredCell = YES;
    }

    DILNotificationHTKTableViewCell *notificationCell = [tableView dequeueReusableCellWithIdentifier:DILNotificationHTKTableViewCellIdentifier forIndexPath:indexPath];

    Notification *notificationForCell = [self notificationForRowAtIndexPath:indexPath];
    [notificationCell configureCellWithNotification:notificationForCell];
    return notificationCell;
}

- (Notification *)notificationForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (Notification *)self.notificationArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGSize defaultSize = [DILNotificationHTKTableViewCell defaultCellSize];

    CGSize cellSize = [DILNotificationHTKTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        Notification *notificationForCell = [self notificationForRowAtIndexPath:indexPath];
        [((DILNotificationHTKTableViewCell *)cellToSetup) configureCellWithNotification:notificationForCell];
        return cellToSetup;
    }];


    return cellSize.height + 1; //accounting for the "magic pixel"
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
@end
