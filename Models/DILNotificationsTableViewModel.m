//
//  DILNotificationsTableViewModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILNotificationsTableViewModel.h"
#import "Notification.h"
#import "DILNotification.h"
#import "DILPushNotificationHandler.h"
#import "DILNotificationHTKTableViewCell.h"

#define WEATHER_IMAGE [UIImage imageNamed:@"cloud394"]
#define WARNING_IMAGE [UIImage imageNamed:@"warning45"]
#define TIME_IMAGE [UIImage imageNamed:@"clock97"]

@interface DILNotificationsTableViewModel()
@property (strong, nonatomic) RLMResults *notificationArray;
@property (strong, nonatomic) NSMutableSet *displayedNotifications;
@property BOOL hasRegisteredCell;
@end

@implementation DILNotificationsTableViewModel
- (id)init {
    if (self = [super init]) {
        [self updateNotificationArray];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotificationArray) name:kDILPushNotificationHandlerRecievedNewNotificationKey object:nil];
    }

    return self;
}

- (void)updateNotificationArray {
    self.notificationArray = [[DILNotification allObjectsInRealm:[[DILPushNotificationHandler sharedPushNotificationHandler] notificationRealm]] sortedResultsUsingProperty:@"dateRecieved" ascending:NO];
    [self.delegate reloadTableDataScrollToTop:YES];
}


- (void)trackDisplayedNotifications {
    self.displayedNotifications = [NSMutableSet new];
}

- (void)markDisplayedNotificationsRead {
    [[[DILPushNotificationHandler sharedPushNotificationHandler] notificationRealm] beginWriteTransaction];
    for (DILNotification *notification in self.displayedNotifications) {
        notification.unread = NO;
    }
    [[[DILPushNotificationHandler sharedPushNotificationHandler] notificationRealm] commitWriteTransaction];
}

#pragma mark - UITableViewDelegate and DataSource
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

    DILNotification *notificationForCell = [self notificationForRowAtIndexPath:indexPath];
    [notificationCell configureCellWithNotification:notificationForCell];
    return notificationCell;
}

- (DILNotification *)notificationForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (DILNotification *)self.notificationArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGSize defaultSize = [DILNotificationHTKTableViewCell defaultCellSize];

    CGSize cellSize = [DILNotificationHTKTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<HTKDynamicResizingCellProtocol> cellToSetup) {
        DILNotification *notificationForCell = [self notificationForRowAtIndexPath:indexPath];
        [((DILNotificationHTKTableViewCell *)cellToSetup) configureCellWithNotification:notificationForCell];
        return cellToSetup;
    }];

    return cellSize.height + 1; //accounting for the "magic pixel"
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    DILNotification *notificationForCell = [self notificationForRowAtIndexPath:indexPath];
    [self.displayedNotifications addObject:notificationForCell];
}

@end
