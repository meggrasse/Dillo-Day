//
//  DILStageSelectTitleView.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/23/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import "DILStageSelectTitleView.h"

#import "DILStageSelectView.h"

#import <PureLayout/PureLayout.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Parse/Parse.h>
#import <PromiseKit/PromiseKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <FXBlurView/FXBlurView.h>
#import <TOMSMorphingLabel/TOMSMorphingLabel.h>

@interface DILStageSelectTitleView()<DILStageSelectDelegate>
@property (strong, nonatomic) UIImageView *selectorImageView;
@property (strong, nonatomic) TOMSMorphingLabel *stageNameLabel;
@property (strong, nonatomic) UIButton *tapButton;

@property (strong, nonatomic) DILStageSelectView *stageSelectView;
@property (strong, nonatomic) FXBlurView *backgroundBlurView;
@property (strong, nonatomic) NSArray *allStagesArray;

@property (nonatomic) BOOL isDisplayingStageSelection;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL hideProgressHUD;
@end

@implementation DILStageSelectTitleView
- (id)initForAutoLayoutWithViewController:(UIViewController *)viewController {
    if (self = [super initForAutoLayout]) {
        self.viewController = viewController;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self fetchStages];
        [self configureView];
    }
    return self;
}

- (void)configureView {
    [self addSubview:self.stageNameLabel];
    [self addSubview:self.selectorImageView];

    [self.stageNameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTrailing];
    [self.stageNameLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.selectorImageView withOffset:-kDILStageSelectTitleViewSelectorImageOffset];


    [self.selectorImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.selectorImageView autoSetDimensionsToSize:kDILStageSelectTitleViewSelectorImageViewSize];
    [self.selectorImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.stageNameLabel];

    [self addSubview:self.tapButton];
    [self.tapButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - Stage Fetching
- (PMKPromise *)fetchAllStagesPromise {
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        PFQuery *stageQuery = [DILPFStage query];
        [stageQuery includeKey:kDILPFStageArtistsKey];
        [stageQuery includeKey:[NSString stringWithFormat:@"%@.%@",kDILPFStageArtistsKey,kDILPFArtistSponsorKey]];
        [stageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                reject(error);
            } else {
                fulfill(objects);
            }
        }];
    }];
}

- (void)fetchStages {
    [self fetchAllStagesPromise].then(^(NSArray *objects) {
        self.allStagesArray = objects;
        if (self.hideProgressHUD) {
            [SVProgressHUD dismiss];
        }
    });
}

- (NSArray *)stageSelectionOptions {
    NSMutableArray *filteredStages = [self.allStagesArray mutableCopy];
    NSUInteger indexOfSelectedStage = [filteredStages indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        DILPFStage *stage = (DILPFStage *)obj;
        if ([stage.objectId isEqual:self.selectedStage.objectId]) {
            *stop = YES;
            return YES;
        } else return NO;
    }];
    if (filteredStages && filteredStages.count) {
        [filteredStages removeObjectAtIndex:indexOfSelectedStage];
    }
    return filteredStages;
}

#pragma mark - View Updating
- (void)setSelectedStage:(DILPFStage *)selectedStage {
    _selectedStage = selectedStage;

    self.stageNameLabel.text = [selectedStage.name uppercaseString];
    [self.stageNameLabel sizeToFit];
}

#pragma mark - Lazily Instantiated Properties
- (UIImageView *)selectorImageView {
    if (!_selectorImageView) {
        _selectorImageView = [[UIImageView alloc] initForAutoLayout];
        _selectorImageView.backgroundColor = [UIColor clearColor];
        _selectorImageView.clipsToBounds = YES;
        _selectorImageView.contentMode = UIViewContentModeScaleAspectFit;
        _selectorImageView.image = [UIImage imageNamed:@"Image"];
    }
    return _selectorImageView;
}

- (TOMSMorphingLabel *)stageNameLabel {
    if (!_stageNameLabel) {
        _stageNameLabel = [[TOMSMorphingLabel alloc] initForAutoLayout];
        _stageNameLabel.font = [UIFont boldSystemFontOfSize:((kDILStageSelectTitleViewTextSize) ? kDILStageSelectTitleViewTextSize : [UIFont systemFontSize])];
    }
    return _stageNameLabel;
}

- (UIButton *)tapButton {
    if (!_tapButton) {
        _tapButton = [[UIButton alloc] initForAutoLayout];
        _tapButton.backgroundColor = [UIColor clearColor];
        [_tapButton addTarget:self action:@selector(handleTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapButton;
}

- (void)handleTap {
    if (!self.allStagesArray) {
        [SVProgressHUD showWithStatus:@"Loading stages..."];
        self.hideProgressHUD = YES;
    } else {
        if (!self.isAnimating) {
            if (self.isDisplayingStageSelection) {
                [self hideStageSelection];
            } else {
                [self showStageSelection];
            }
        }
    }

}

- (DILStageSelectView *)stageSelectView {
    if (!_stageSelectView) {
        _stageSelectView = [[DILStageSelectView alloc] init];
        _stageSelectView.delegate = self;
    }

    return _stageSelectView;
}

- (FXBlurView *)backgroundBlurView {
    if (!_backgroundBlurView) {
        _backgroundBlurView = [[FXBlurView alloc] initForAutoLayout];
        _backgroundBlurView.tintColor = [UIColor clearColor];
        _backgroundBlurView.dynamic = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap)];
        [_backgroundBlurView addGestureRecognizer:tapGestureRecognizer];

    }
    return _backgroundBlurView;
}

- (void)handleBackgroundTap {
    [self hideStageSelection];
}

#pragma mark - Stage Selection Animators
- (void)showStageSelection {
    self.stageSelectView.stageArray = [self stageSelectionOptions];

    self.isAnimating = YES;
    CGSize stageSelectViewSize = [self sizeForStageSelectView];
    CGRect initialFrame = CGRectMake(0, 0, stageSelectViewSize.width, stageSelectViewSize.height);
    initialFrame.origin.y = -CGRectGetHeight(initialFrame);
    self.stageSelectView.frame = initialFrame;

    self.backgroundBlurView.alpha = 0;

    UIView *baseView = self.viewController.view;
    [baseView addSubview:self.backgroundBlurView];
    [baseView addSubview:self.stageSelectView];
    [self.backgroundBlurView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [UIView animateWithDuration:kDILStageSelectTitleViewAnimationDuration animations:^{
        CGRect finalFrame = self.stageSelectView.bounds;
        self.stageSelectView.frame = finalFrame;
        self.selectorImageView.transform = CGAffineTransformRotate(self.selectorImageView.transform, -M_PI);
        self.backgroundBlurView.alpha = 1;
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
        self.isDisplayingStageSelection = YES;
    }];

}

- (void)hideStageSelection {
    self.isAnimating = YES;
    [UIView animateWithDuration:kDILStageSelectTitleViewAnimationDuration animations:^{
        CGRect finalFrame = self.stageSelectView.bounds;
        finalFrame.origin.y = -CGRectGetHeight(finalFrame);
        self.stageSelectView.frame = finalFrame;
        self.selectorImageView.transform = CGAffineTransformRotate(self.selectorImageView.transform, M_PI);
        self.backgroundBlurView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.stageSelectView removeFromSuperview];
        [self.backgroundBlurView removeFromSuperview];
        self.stageSelectView = nil;
        self.isAnimating = NO;
        self.isDisplayingStageSelection = NO;
    }];
}

- (CGSize)sizeForStageSelectView {
    return CGSizeMake(CGRectGetWidth(self.viewController.view.bounds), [self.stageSelectView heightForView]);
}

#pragma mark - DILStageSelectDelegate 
- (void)didSelectStage:(DILPFStage *)stage {
    [self hideStageSelection];
    [self.delegate didSelectStage:stage];
}

@end
