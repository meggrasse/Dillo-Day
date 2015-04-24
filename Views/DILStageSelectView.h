//
//  DILStageSelectView.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/23/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DILPFStage.h"

@protocol DILStageSelectDelegate <NSObject>
@required
- (void)didSelectStage:(DILPFStage *)stage;
@end

@interface DILStageSelectView : UIView
@property (weak, nonatomic) id<DILStageSelectDelegate> delegate;
@property (strong, nonatomic) NSArray *stageArray;

/**
 *  Only call after setting the stageArray property!
 *
 *  @return The height for the vc.
 */
- (CGFloat)heightForView;
@end
