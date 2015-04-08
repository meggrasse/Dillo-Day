//
//  DILPFArtist.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>
#import <PromiseKit/PromiseKit.h>

#import "DILPFSponsor.h"
#import "DILPFStage.h"


extern NSString *const kDILPFArtistClassKey;
extern NSString *const kDILPFArtistSponsorKey;

@class DILPFSponsor;
@class DILPFStage;

@interface DILPFArtist : PFObject<PFSubclassing>
@property (retain) NSString *name;
@property (retain) NSDate *performanceTime;
@property (retain) PFFile *lineupImage;
@property (retain) NSString *about;
@property (retain) DILPFSponsor *sponsor;
@property (retain) DILPFStage *stage;
@property (retain) NSMutableArray *youtubeVideoIds;
@property (nonatomic) BOOL artistAlerts;

/**
 *  Returns a promise that returns a UIImage of the DILPFArtist object's lineupImage.
 *
 *  @return A promise that returns a UIImage of the DILPFArtist object's lineupImage.
 */
- (PMKPromise *)imageDownloadPromise;
@end

