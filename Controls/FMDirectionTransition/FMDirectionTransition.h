//
//  FMDirectionTransition.h
//  TransitionExample
//
//  Created by Phil Meyers IV on 2/9/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    FMDirectionTransitionTypeUp = 0,
    FMDirectionTransitionTypeDown,
    FMDirectionTransitionTypeLeft,
    FMDirectionTransitionTypeRight
} FMDirectionTransitionType;

@interface FMDirectionTransition : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (nonatomic) FMDirectionTransitionType direction;
@end
