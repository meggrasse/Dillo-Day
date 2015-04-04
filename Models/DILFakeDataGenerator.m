//
//  DILFakeDataGenerator.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/31/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILFakeDataGenerator.h"
#import "DILPFArtist.h"
#import "DILPFSponsor.h"
#import "DILPFStage.h"

@implementation DILFakeDataGenerator
- (void)generateData {
    [self constructFakeDatabase];
}

- (void)constructFakeDatabase {
    NSArray *stageNames = @[@"Main Stage", @"Side Stage 1", @"Side Stage 2", @"Side Stage 3"];
    for (NSString *stageName in stageNames) {
        DILPFStage *stage = [DILPFStage object];
        stage.name = stageName;
        stage.artists = [NSMutableArray new];
        [stage save];

        NSArray *youtubeVideoIds = @[@"debIyWS6Byc",
                                     @"WMq6MLo_eSM",
                                     @"CdLhdrNgGu4",
                                     @"HkMNOlYcpHg",
                                     @"AOPMlIIg_38"];

        NSArray *artistNames = @[@"pizza!",
                                 @"radio frenzy",
                                 @"Lana Del Rey",
                                 @"Kid Cudi",
                                 @"The Gorillaz",
                                 @"50 Cent",
                                 @"lil b #basedgod",
                                 @"U2"];

        NSArray *bigPics = @[[UIImage imageNamed:@"pizza big"],
                             [UIImage imageNamed:@"radio big"],
                             [UIImage imageNamed:@"lana big"],
                             [UIImage imageNamed:@"kid cudi big"],
                             [UIImage imageNamed:@"gorillaz big"],
                             [UIImage imageNamed:@"50 big"],
                             [UIImage imageNamed:@"lil b big"],
                             [UIImage imageNamed:@"u2 big"]];

        NSString *artistText = @"Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec sed odio dui. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec sed odio dui. \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas faucibus mollis interdum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.\n\nCras justo odio, dapibus ac facilisis in, egestas eget quam. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec id elit non mi porta gravida at eget metus.";

        for (int i = 0; i < [artistNames count]; i++) {
            DILPFArtist *newArtist = [DILPFArtist object];
            newArtist.name = artistNames[i];
            newArtist.performanceTime = [NSDate date];
            newArtist.lineupImage = [PFFile fileWithData:UIImagePNGRepresentation((UIImage *)bigPics[i])];
            newArtist.about = artistText;
            newArtist.youtubeVideoIds = youtubeVideoIds;
            [newArtist save];

            DILPFSponsor *sponsor = [DILPFSponsor object];
            sponsor.name = @"Dell Computers";
            sponsor.sponsoredArtist = newArtist;
            [sponsor save];
            
            newArtist.sponsor = sponsor;
            [newArtist save];

            [stage.artists addObject:newArtist];
        }

        [stage save];
    }
}


@end
