//
//  LineupModel.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/20/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "LineupModel.h"
@interface LineupModel()
@property (strong, nonatomic) NSMutableArray *lineupArray;
@end


@implementation LineupModel
- (id)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.lineupArray = [NSMutableArray new];
    [self constructFakeDatabase];
}

- (void)constructFakeDatabase {
    NSArray *artistNames = @[@"pizza!",
                             @"radio frenzy",
                             @"Lana Del Rey",
                             @"Kid Cudi",
                             @"The Gorillaz",
                             @"50 Cent",
                             @"lil b #basedgod",
                             @"U2"];
    NSArray *artistTimes = @[@"1:00 PM",
                             @"2:00 PM",
                             @"3:00 PM",
                             @"4:00 PM",
                             @"5:00 PM",
                             @"6:00 PM",
                             @"7:00 PM",
                             @"8:00 PM"];
    for (int i = 0; i < [artistNames count]; i++) {
        Artist *newArtist = [Artist new];
        newArtist.name = artistNames[i];
        newArtist.time = artistTimes[i];
        [self.lineupArray addObject:newArtist];
    }
}

#pragma mark - Model Accessors
- (NSUInteger)numberOfSections {
    return 1;
}
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section {
    return [self.lineupArray count];
}
- (Artist *)artistForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.lineupArray[indexPath.row];
}

@end
