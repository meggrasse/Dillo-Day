//
//  FMColorTransition.h
//  FMColorTransition
//
//  Created by Phil Meyers IV on 2/6/15.
//  Copyright (c) 2015 FeelMyEars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    FMColorTransitionTypeUp = 0,
    FMColorTransitionTypeDown,
    FMColorTransitionTypeLeft,
    FMColorTransitionTypeRight
} FMColorTransitionType;

@interface FMColorTransition : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (assign) UIColor *transitionColor;
@property (nonatomic) FMColorTransitionType transitionType;
@end
