//
//  Notification.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum NSUInteger {
    NotificationPriorityLevelLow = 0,
    NotificationPriorityLevelMedium,
    NotificationPriorityLevelHigh
} NotificationPriorityLevel;

@interface Notification : NSObject
- (id)initWithMessage:(NSString *)message
                image:(UIImage *)image
         dateReceived:(NSDate *)date;

@property (strong, nonatomic) NSDate *dateRecieved;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) NotificationPriorityLevel priorityLevel;
@end
