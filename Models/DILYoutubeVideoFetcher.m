//
//  DILYoutubeVideoFetcher.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/3/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILYoutubeVideoFetcher.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import <SDWebImage/SDWebImageManager.h>
#import <PromiseKit/PromiseKit.h>

@interface DILYoutubeVideoFetcher()

@end

static NSString *const kDownloadVideoImagePromiseFulfillVideoKey = @"kDownloadVideoImagePromiseFulfillVideoKey";
static NSString *const kDownloadVideoImagePromiseFulfillImageKey = @"kDownloadVideoImagePromiseFulfillImageKey";

@implementation DILYoutubeVideoFetcher

+ (instancetype)sharedVideoFetcher {
    static DILYoutubeVideoFetcher *_sharedVideoFetcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedVideoFetcher = [DILYoutubeVideoFetcher new];
    });
    
    return _sharedVideoFetcher;
}

- (void)fetchVideosForIds:(NSArray *)youtubeVideoIds forSender:(id<DILYoutubeVideoFetcherDelegate>)sender {
    for (NSString *youtubeVideoId in youtubeVideoIds) {
        [self fetchVideoPromise:youtubeVideoId].then(^(XCDYouTubeVideo *video){
            return [self downloadVideoImagePromise:video];
        }).then(^(NSDictionary *downloadVideoImagePromiseDictionary){
            XCDYouTubeVideo *video = downloadVideoImagePromiseDictionary[kDownloadVideoImagePromiseFulfillVideoKey];
            UIImage *image = downloadVideoImagePromiseDictionary[kDownloadVideoImagePromiseFulfillImageKey];
            [sender fetchedVideo:video image:image];
        });
    }
}

- (PMKPromise *)fetchVideoPromise:(NSString *)youtubeVideoId {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:youtubeVideoId completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
            if (error) {
                reject(error);
            } else {
                fulfill(video);
            }
        }];
    }];
}

- (PMKPromise *)downloadVideoImagePromise:(XCDYouTubeVideo *)video {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:video.mediumThumbnailURL options:0 progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (error) {
                reject(error);
            } else {
                fulfill(@{kDownloadVideoImagePromiseFulfillImageKey : image,
                          kDownloadVideoImagePromiseFulfillVideoKey : video
                          });
            }
        }];
    }];
}
@end
