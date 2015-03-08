//
//  NotificationHTKCollectionViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "HTKDynamicResizingCollectionViewCell.h"
#import "Notification.h"

#define DEFAULT_NOTIFICATION_CELL_SIZE  CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), 50)

@interface NotificationHTKCollectionViewCell : HTKDynamicResizingCollectionViewCell
- (void)setupCellWithNotification:(Notification *)notification;
@end
