//
//  Artist.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/20/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>

@interface Artist : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) UIImage *bigImage;
@property (strong, nonatomic) UIImage *smallImage;
@property (strong, nonatomic) NSString *aboutText;
@property (strong, nonatomic) NSMutableArray *youtubeVideoIds;
@property (strong, nonatomic) NSMutableArray *youtubeVideos;

@end
