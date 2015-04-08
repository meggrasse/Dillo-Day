//
//  DILPFArtist.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPFArtist.h"
#import <Realm/Realm.h>
#import "DILFollowArtist.h"

NSString *const kDILPFArtistClassKey = @"DILPFArtist";
NSString *const kDILPFArtistSponsorKey = @"sponsor";

@implementation DILPFArtist
@dynamic name;
@dynamic performanceTime;
@dynamic lineupImage;
@dynamic about;
@dynamic sponsor;
@dynamic stage;
@dynamic youtubeVideoIds;

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

- (BOOL)artistAlerts {
    DILFollowArtist *followArtistResult = [DILFollowArtist objectForPrimaryKey:self.objectId];
    return followArtistResult && followArtistResult.follow;
}

- (void)setArtistAlerts:(BOOL)artistAlerts {
    DILFollowArtist *followArtistResult = [DILFollowArtist objectForPrimaryKey:self.objectId];

    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    if (!followArtistResult) {
        followArtistResult = [[DILFollowArtist alloc] init];
        followArtistResult.artistObjectId = self.objectId;
        followArtistResult.follow = NO;
        [defaultRealm addObject:followArtistResult];
    }

    followArtistResult.follow = artistAlerts;
    [defaultRealm commitWriteTransaction];
}
@end