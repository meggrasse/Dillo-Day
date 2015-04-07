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

#import "UIApplication+NetworkActivityIndicator.h"
#import <TMCache/TMCache.h>

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
        [[UIApplication sharedApplication] beganNetworkActivity];
        [self fetchVideoPromise:youtubeVideoId].then(^(XCDYouTubeVideo *video){
            return [self downloadVideoImagePromise:video];
        }).then(^(NSDictionary *downloadVideoImagePromiseDictionary){
            XCDYouTubeVideo *video = downloadVideoImagePromiseDictionary[kDownloadVideoImagePromiseFulfillVideoKey];
            UIImage *image = downloadVideoImagePromiseDictionary[kDownloadVideoImagePromiseFulfillImageKey];
            [sender fetchedVideo:video image:image];
        }).finally(^(){
            [[UIApplication sharedApplication] endedNetworkActivity];
        });
    }
}

#pragma mark - Caching
- (void)cacheYoutubeVideo:(XCDYouTubeVideo *)videoToCache {
    [[[TMCache sharedCache] memoryCache] setObject:videoToCache forKey:videoToCache.identifier];
}

- (PMKPromise *)retrieveVideoFromCachePromise:(NSString *)videoIdentifier {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [[[TMCache sharedCache] memoryCache] objectForKey:videoIdentifier block:^(TMMemoryCache *cache, NSString *key, id object) {
            fulfill(object);
        }];
    }];
}

#pragma mark - Video Fetching
- (PMKPromise *)fetchVideoPromise:(NSString *)youtubeVideoId {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        [self retrieveVideoFromCachePromise:youtubeVideoId].then(^(XCDYouTubeVideo *video){
            if (video) {
                fulfill(video);
            } else {
                [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:youtubeVideoId completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
                    if (error) {
                        reject(error);
                    } else {
                        [self cacheYoutubeVideo:video];
                        fulfill(video);
                    }
                }];
            }
        });
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
