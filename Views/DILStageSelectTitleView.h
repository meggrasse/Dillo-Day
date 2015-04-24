//
//  DILStageSelectTitleView.h
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/23/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILPFStage.h"

static const CGFloat kDILStageSelectTitleViewSelectorImageOffset = 5.0;
static const CGFloat kDILStageSelectTitleViewTextSize = 18.0; //If 0, use the standard system font
static const CGSize kDILStageSelectTitleViewSelectorImageViewSize = (CGSize){10,10};
static const CGFloat kDILStageSelectTitleViewAnimationDuration = 0.33;

@class DILStageSelectTitleView;

@protocol DILStageSelectTitleViewDelegate <NSObject>
@required
- (void)didSelectStage:(DILPFStage *)stage;
@end

@interface DILStageSelectTitleView : UIView
@property (weak, nonatomic) id<DILStageSelectTitleViewDelegate>delegate;
@property (weak, nonatomic) UIViewController *viewController;

@property (strong, nonatomic) DILPFStage *selectedStage;

- (id)initForAutoLayoutWithViewController:(UIViewController *)viewController;
@end
