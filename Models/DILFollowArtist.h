//
//  DILFollowArtist.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/1/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Realm/Realm.h>

@interface DILFollowArtist : RLMObject
@property NSString *artistObjectId;
@property BOOL follow;
@end
