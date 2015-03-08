//
//  Notification.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "Notification.h"

@implementation Notification
- (id)initWithMessage:(NSString *)message image:(UIImage *)image dateReceived:(NSDate *)date {
    if (self = [super init]) {
        self.message = message;
        self.image = image;
        self.dateRecieved = date;
    }
    return self;
}
@end
