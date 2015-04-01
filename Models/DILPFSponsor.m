//
//  DILPFSponsor.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPFSponsor.h"

NSString *const kDILPFSponsorClassKey = @"DILPFSponsor";

@implementation DILPFSponsor
@dynamic name;
@dynamic sponsoredArtist;
@dynamic sponsorLogo;

+ (NSString *)parseClassName {
    return kDILPFSponsorClassKey;
}

+ (void)load {
    [self registerSubclass];
}
@end
