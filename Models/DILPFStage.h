//
//  DILPFStage.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>

#import "DILPFArtist.h"

extern NSString *const kDILPFStageClassKey;
extern NSString *const kDILPFStageArtistsKey;

@interface DILPFStage : PFObject<PFSubclassing>
@property (retain) NSString *name;

/**
 *  Array of DILPFArtist objects.
 */
@property (retain) NSMutableArray *artists;
@end
