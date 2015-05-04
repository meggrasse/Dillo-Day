//
//  DILPFMap.h
//  
//
//  Created by Phil Meyers IV on 5/1/15.
//
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@interface DILPFMap : PFObject<PFSubclassing>
@property (retain) PFFile *mapFile;
@property (retain) NSString *mapName;
@property (retain) NSNumber *currentMap;
@end
