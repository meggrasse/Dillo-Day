//
//  DILYoutubeVideoFetcher.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/3/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "DILPFYoutubeVideo.h"

@protocol DILYoutubeVideoFetcherDelegate <NSObject>
@required
- (void)fetchedVideo:(XCDYouTubeVideo *)video image:(UIImage *)image;
- (void)fetchedDILPFYoutubeVideo:(DILPFYoutubeVideo *)video;
@end

@interface DILYoutubeVideoFetcher : NSObject
+ (id)sharedVideoFetcher;
- (void)fetchVideosForIds:(NSArray *)youtubeVideoIds forSender:(id<DILYoutubeVideoFetcherDelegate>)sender;
- (void)fetchVideosForArtist:(DILPFArtist *)artist forSender:(id<DILYoutubeVideoFetcherDelegate>)sender;
@end
