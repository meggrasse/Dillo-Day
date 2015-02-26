//
//  Artist.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/20/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "Artist.h"

@implementation Artist
- (NSMutableArray *)youtubeVideos {
    if (!_youtubeVideos) {
        _youtubeVideos = [NSMutableArray new];
    }
    
    return _youtubeVideos;
}

- (void)setYoutubeVideoIds:(NSMutableArray *)youtubeVideoIds {
    _youtubeVideoIds = youtubeVideoIds;
    for (NSString *videoId in youtubeVideoIds) {
        [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoId completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
            [self.youtubeVideos addObject:video];
        }];
    }
}

@end
