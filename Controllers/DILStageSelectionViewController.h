//
//  DILStageSelectionViewController.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 3/28/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DILPFStage.h"

@class DILStageSelectionViewController;
@protocol DILStageSelectionDelegate <NSObject>
@required
- (void)didSelectStage:(DILPFStage *)stage;
@end

@interface DILStageSelectionViewController : UIViewController
@property (weak, nonatomic) id<DILStageSelectionDelegate> delegate;
@property (strong, nonatomic) NSArray *stageArray;

/**
 *  Only call after setting the stageArray property!
 *
 *  @return The height for the vc.
 */
- (CGFloat)heightForViewController;
@end
