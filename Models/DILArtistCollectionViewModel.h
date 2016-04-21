//
//  DILArtistCollectionViewModel.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DILPFArtist.h"

typedef enum NSUInteger {
    DILArtistInfoTypeBio = 0,
    DILArtistInfoTypeMusic,
} DILArtistInfoType;

@protocol DILArtistCollectionViewModelDelegate <NSObject>
@required
- (void)reloadSection:(NSUInteger)section;
- (void)insertItemAtIndex:(NSIndexPath *)indexPath;
@end

@interface DILArtistCollectionViewModel : NSObject<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) id<DILArtistCollectionViewModelDelegate> delegate;
@property (strong, nonatomic) DILPFArtist *artist;
- (id)initWithArtist:(DILPFArtist *)artist;
@end
