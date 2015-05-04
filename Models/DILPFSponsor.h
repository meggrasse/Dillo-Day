//
//  DILPFSponsor.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "DILPFArtist.h"

extern NSString *const kDILPFSponsorClassKey;
@class DILPFArtist;

@interface DILPFSponsor : PFObject<PFSubclassing>
@property (retain) NSString *name;
@property (retain) DILPFArtist *sponsoredArtist;
@property (retain) PFFile *sponsorLogo;
@end
