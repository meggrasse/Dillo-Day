//
//  DILPFYoutubeVideo.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/18/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "DILPFArtist.h"

@interface DILPFYoutubeVideo : PFObject<PFSubclassing>
@property (retain) NSString *title;
@property (retain) DILPFArtist *artist;
@property (retain) NSString *videoId;
@property (retain) NSString *videoURL;
@property (retain) PFFile *thumbnail;

- (NSURL *)youtubeVideoURL;
@end
