//
//  NSObject+DILPFMapFeatures.m
//  Dillo Day
//
//  Created by Meg Grasse on 4/29/16.
//  Copyright © 2016 Mayfest. All rights reserved.
//

#import "DILPFMapFeatures.h"

NSString *const  kDILPFMapFeaturesKey = @"DILPFMapFeatures";

@implementation DILPFMapFeatures
@dynamic location;

+ (NSString *)parseClassName {
    return kDILPFMapFeaturesKey;
}

+ (void)load {
    [self registerSubclass];
}

@end

