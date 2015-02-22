//
//  LineupModel.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 2/20/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"
#import <UIKit/UIKit.h>

@interface LineupModel : NSObject
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfItemsInSection:(NSUInteger)section;
- (Artist *)artistForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
