//
//  DILPFMap.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/27/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>



@interface DILPFMap : PFObject<PFSubclassing>
@property (retain) PFFile *mapFile;
@property (retain) NSString *mapName;
@property (retain)
@end
