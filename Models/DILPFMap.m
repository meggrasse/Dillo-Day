//
//  DILPFMap.m
//  
//
//  Created by Phil Meyers IV on 5/1/15.
//
//

#import "DILPFMap.h"

@implementation DILPFMap
@dynamic mapFile;
@dynamic mapName;
@dynamic currentMap;

+ (NSString *)parseClassName {
    return NSStringFromClass([self class]);
}

+ (void)load {
    [self registerSubclass];
}

@end
