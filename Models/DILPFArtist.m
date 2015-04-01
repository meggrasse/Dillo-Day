//
//  DILPFArtist.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPFArtist.h"

NSString *const kDILPFArtistClassKey = @"DILPFArtist";
NSString *const kDILPFArtistSponsorKey = @"sponsor";

@implementation DILPFArtist
@dynamic name;
@dynamic performanceTime;
@dynamic lineupImage;
@dynamic about;
@dynamic sponsor;
@dynamic stage;

+ (NSString *)parseClassName {
    return kDILPFArtistClassKey;
}

+ (void)load {
    [self registerSubclass];
}

- (PMKPromise *)imageDownloadPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [self.lineupImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (error) {
                reject(error);
            } else {
                UIImage *image = [UIImage imageWithData:data];
                fulfill(image);
            }
        }];
    }];
}
@end
