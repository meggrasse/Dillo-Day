//
//  NotificationModel.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"

@interface NotificationModel : NSObject
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;
- (Notification *)notificationForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
