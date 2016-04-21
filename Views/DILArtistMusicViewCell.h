//
//  DILArtistMusicViewCell.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFArtist.h"

@interface DILArtistMusicViewCell : UICollectionViewCell
- (void)configureCellWithArtist:(DILPFArtist *)artist;
+ (NSString *)identifier;
@end
