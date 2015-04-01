//
//  DILPFStage.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPFStage.h"

NSString *const kDILPFStageClassKey = @"DILPFStage";
NSString *const kDILPFStageArtistsKey = @"artists";

@implementation DILPFStage
@dynamic name;
@dynamic artists;

+ (NSString *)parseClassName {
    return kDILPFStageClassKey;
}

+ (void)load {
    [self registerSubclass];
}

@end
