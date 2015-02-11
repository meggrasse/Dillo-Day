//
//  FMDirectionTransition.m
//  TransitionExample
//
//  Created by Phil Meyers IV on 2/9/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

#import "FMDirectionTransition.h"
@interface FMDirectionTransition()
@property (nonatomic) BOOL isPresenting;
@end

static CGFloat springDamping = 1;
static CGFloat initialSpringVelocity = 0;

@implementation FMDirectionTransition
#pragma mark - UIViewControllerTransitioningDelegate Implementation
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning Implementation
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGSize frameSize = [transitionContext initialFrameForViewController:fromViewController].size;
    
    toViewController.view.frame = [self intialToFrameWithSize:frameSize transitionType:self.direction presenting:self.isPresenting];
    fromViewController.view.frame = [self initialFromFrameWithSize:frameSize transitionType:self.direction presenting:self.isPresenting];
    
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    //Scale the 'to' view to to its final position
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:springDamping initialSpringVelocity:initialSpringVelocity options:0 animations:^{
        toViewController.view.frame = [self finalToFrameWithSize:frameSize transitionType:self.direction presenting:self.isPresenting];
        fromViewController.view.frame = [self finalFromFrameWithSize:frameSize transitionType:self.direction presenting:self.isPresenting];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}

- (CGRect)initialFromFrameWithSize:(CGSize)size transitionType:(FMDirectionTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    return frame;
}

- (CGRect)finalFromFrameWithSize:(CGSize)size transitionType:(FMDirectionTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGFloat presentingMultiplier = (presenting) ? 1 : -1;
    switch (type) {
        case FMDirectionTransitionTypeUp: {
            frame.origin.y = presentingMultiplier * 1 * CGRectGetHeight(frame);
            return frame;
        }
        case FMDirectionTransitionTypeDown: {
            frame.origin.y = presentingMultiplier * -1 * CGRectGetHeight(frame);
            return frame;
        }
        case FMDirectionTransitionTypeLeft: {
            frame.origin.x = presentingMultiplier * -1 * CGRectGetWidth(frame);
            return frame;
        }
        case FMDirectionTransitionTypeRight: {
            frame.origin.x = presentingMultiplier * 1 * CGRectGetWidth(frame);
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}

- (CGRect)finalToFrameWithSize:(CGSize)size transitionType:(FMDirectionTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    return frame;
}

- (CGRect)intialToFrameWithSize:(CGSize)size transitionType:(FMDirectionTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGFloat presentingMultiplier = (presenting) ? 1 : -1;
    switch (type) {
        case FMDirectionTransitionTypeUp: {
            frame.origin.y = presentingMultiplier*-1*CGRectGetHeight(frame);
            return frame;
        }
        case FMDirectionTransitionTypeDown: {
            frame.origin.y = presentingMultiplier*1*CGRectGetHeight(frame);
            return frame;
        }
        case FMDirectionTransitionTypeLeft: {
            frame.origin.x = presentingMultiplier*1*CGRectGetWidth(frame);
            return frame;
        }
        case FMDirectionTransitionTypeRight: {
            frame.origin.x = presentingMultiplier*-1*CGRectGetWidth(frame);
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}
@end
