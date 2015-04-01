//
//  DILNotificationHTKTableViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "HTKDynamicResizingTableViewCell.h"
#import "Notification.h"

@interface DILNotificationHTKTableViewCell : HTKDynamicResizingTableViewCell
- (void)configureCellWithNotification:(Notification *)notification;
+ (CGSize)defaultCellSize;
@end
