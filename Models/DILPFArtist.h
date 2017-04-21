//
//  DILPFArtist.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
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
@property (retain) PFFile *iconImage;
@property (retain) NSString *about;
@property (retain) DILPFSponsor *sponsor;
@property (retain) DILPFStage *stage;
@property (nonatomic) BOOL artistAlerts;
@property (retain) NSNumber *announced;
@property (retain) NSString *previewUrl;
@property (retain) NSString *spotifyUrl;
@property (retain) NSString *tidalUrl;
@property (retain) NSString *aplUrl;
@property (retain) NSString *soundcloudUrl;
@property (retain) NSString *youtubeUrl;
@property (retain) NSString *soundcloudUsername;
@property (retain) NSNumber *lineupCollectionViewOrder;
@property (nonatomic) BOOL isBeingAnnounced;
@property (retain) NSString *announcementVideoId;

/**
 *  Returns a promise that returns a UIImage of the DILPFArtist object's lineupImage.
 *
 *  @return A promise that returns a UIImage of the DILPFArtist object's lineupImage.
 */
- (PMKPromise *)imageDownloadPromise;

- (PMKPromise *)iconImageDownloadPromise;

@end

