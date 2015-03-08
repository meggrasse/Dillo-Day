//
//  ArtistInfoViewController.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/21/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

typedef enum NSUInteger {
    ArtistInfoTypeBio = 0,
    ArtistInfoTypeMusic,
    ArtistInfoTypeShare
} ArtistInfoType;

@interface ArtistInfoViewController : UIViewController
@property (strong, nonatomic) Artist *artist;
@end
