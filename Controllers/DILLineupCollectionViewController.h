//
//  DILLineupCollectionViewController.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/7/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFStage.h"

@protocol DILLineupCollectionViewControllerDelegate <NSObject>
@required
- (void)didSelectArtist:(DILPFArtist *)artist;
@end

@interface DILLineupCollectionViewController : UIViewController
@property (strong, nonatomic) DILPFStage *stage;
@property (weak, nonatomic) id<DILLineupCollectionViewControllerDelegate> delegate;
- (id)initWithStage:(DILPFStage *)stage;
- (void)reloadData;
@end
