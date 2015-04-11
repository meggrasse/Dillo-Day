//
//  DILNotification.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/10/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface DILNotification : RLMObject
@property NSString *alert;
@property NSDate *dateRecieved;
@property BOOL unread;
@end
