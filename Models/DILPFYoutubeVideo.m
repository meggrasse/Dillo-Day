//
//  DILPFYoutubeVideo.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 5/18/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILPFYoutubeVideo.h"

@implementation DILPFYoutubeVideo
@dynamic title;
@dynamic artist;
@dynamic videoId;
@dynamic videoURL;
@dynamic thumbnail;

+ (NSString *)parseClassName {
	return NSStringFromClass([self class]);
}

+ (void)load {
	[self registerSubclass];
}

- (NSURL *)youtubeVideoURL {
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseURL], self.videoId]];
}

- (NSString  *)baseURL {
	return @"https://www.youtube.com/watch?v=";
}
@end
