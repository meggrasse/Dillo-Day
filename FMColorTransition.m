//
//  FMColorTransition.m
//  FMColorTransition
//
//  Created by Phil Meyers IV on 2/6/15.
//  Copyright (c) 2015 FeelMyEars. All rights reserved.
//

#import "FMColorTransition.h"
@interface FMColorTransition()
@property (nonatomic) BOOL isPresenting;
@end


@implementation FMColorTransition

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
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectZero];
//    if (self.transitionColor) {
//        colorView.backgroundColor = self.transitionColor;
//    }
//    
    toViewController.view.frame = [self intialToFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
    fromViewController.view.frame = [self initialFromFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
    colorView.frame = [self intialColorViewFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
    
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    [containerView insertSubview:colorView aboveSubview:fromViewController.view];
    
    //Scale the 'to' view to to its final position
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:3 initialSpringVelocity:0.0 options:0 animations:^{
        toViewController.view.frame = [self finalToFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
        fromViewController.view.frame = [self finalFromFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
        colorView.frame = [self finalColorViewFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [colorView removeFromSuperview];
    }];
//    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        toViewController.view.frame = [self finalToFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        fromViewController.view.frame = [self finalFromFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        colorView.frame = [self finalColorViewFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//        [colorView removeFromSuperview];
//    }];

//
//    if (self.isPresenting == YES) {
//        //Add 'to' view to the hierarchy with 0.0 scale
//        /*
//         CGRect finalToFrame = [transitionContext initialFrameForViewController:fromViewController];
//         CGRect initialToFrame = finalToFrame;
//         initialToFrame.origin.y = - 2*CGRectGetHeight(initialToFrame);
//         toViewController.view.frame = initialToFrame;
//         
//         CGRect initialFromFrame = finalToFrame;
//         CGRect finalFromFrame = initialFromFrame;
//         finalFromFrame.origin.y = 2*CGRectGetHeight(initialFromFrame);
//         
//         CGRect colorViewFrame = finalToFrame;
//         CGRect initialColorViewFrame = colorViewFrame;
//         CGRect finalColorViewFrame = colorViewFrame;
//         initialColorViewFrame.origin.y = -1*CGRectGetHeight(colorViewFrame);
//         finalColorViewFrame.origin.y = 1*CGRectGetHeight(colorViewFrame);
//         */
//        
//        toViewController.view.frame = [self intialToFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        fromViewController.view.frame = [self initialFromFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        colorView.frame = [self intialColorViewFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        
//        [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
//        [containerView insertSubview:colorView aboveSubview:fromViewController.view];
//        
//        //Scale the 'to' view to to its final position
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//            toViewController.view.frame = [self finalToFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//            fromViewController.view.frame = [self finalFromFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//            colorView.frame = [self finalColorViewFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        } completion:^(BOOL finished) {
//            [transitionContext completeTransition:YES];
//            [colorView removeFromSuperview];
//        }];
//    } else if (self.isPresenting == NO) {
//        //Add 'to' view to the hierarchy
//        /*
//         CGRect finalToFrame = [transitionContext initialFrameForViewController:fromViewController];
//         CGRect initialToFrame = finalToFrame;
//         initialToFrame.origin.y = 2*CGRectGetHeight(initialToFrame);
//         toViewController.view.frame = initialToFrame;
//         
//         CGRect initialFromFrame = finalToFrame;
//         CGRect finalFromFrame = initialFromFrame;
//         finalFromFrame.origin.y = - 2*CGRectGetHeight(initialFromFrame);
//         
//         CGRect colorViewFrame = finalToFrame;
//         CGRect initialColorViewFrame = colorViewFrame;
//         CGRect finalColorViewFrame = colorViewFrame;
//         initialColorViewFrame.origin.y = 1*CGRectGetHeight(colorViewFrame);
//         finalColorViewFrame.origin.y = -1*CGRectGetHeight(colorViewFrame);
//         
//         [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
//         [containerView insertSubview:colorView aboveSubview:fromViewController.view];
//         
//         //Scale the 'from' view down until it disappears
//         [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//         toViewController.view.frame = finalToFrame;
//         fromViewController.view.frame = finalFromFrame;
//         } completion:^(BOOL finished) {
//         [transitionContext completeTransition:YES];
//         [colorView removeFromSuperview];
//         }];
//         */
//        toViewController.view.frame = [self intialToFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        fromViewController.view.frame = [self initialFromFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        colorView.frame = [self intialColorViewFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        
//        [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
//        [containerView insertSubview:colorView aboveSubview:fromViewController.view];
//        
//        //Scale the 'to' view to to its final position
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//            toViewController.view.frame = [self finalToFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//            fromViewController.view.frame = [self finalFromFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//            colorView.frame = [self finalColorViewFrameWithSize:frameSize transitionType:self.transitionType presenting:self.isPresenting];
//        } completion:^(BOOL finished) {
//            [transitionContext completeTransition:YES];
//            [colorView removeFromSuperview];
//        }];
//    }
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}

- (CGRect)initialFromFrameWithSize:(CGSize)size transitionType:(FMColorTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    switch (type) {
        case FMColorTransitionTypeUp: {
            return frame;
        }
        case FMColorTransitionTypeDown: {
            return frame;
        }
        case FMColorTransitionTypeLeft: {
            return frame;
        }
        case FMColorTransitionTypeRight: {
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}

- (CGRect)finalFromFrameWithSize:(CGSize)size transitionType:(FMColorTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGFloat presentingMultiplier = (presenting) ? 1 : -1;
    switch (type) {
        case FMColorTransitionTypeUp: {
            frame.origin.y = presentingMultiplier * 2 * CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeDown: {
            frame.origin.y = presentingMultiplier * -2 * CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeLeft: {
            frame.origin.x = presentingMultiplier * -2 * CGRectGetWidth(frame);
            return frame;
        }
        case FMColorTransitionTypeRight: {
            frame.origin.x = presentingMultiplier * 2 * CGRectGetWidth(frame);
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}

- (CGRect)finalToFrameWithSize:(CGSize)size transitionType:(FMColorTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    switch (type) {
        case FMColorTransitionTypeUp: {
            return frame;
        }
        case FMColorTransitionTypeDown: {
            return frame;
        }
        case FMColorTransitionTypeLeft: {
            return frame;
        }
        case FMColorTransitionTypeRight: {
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}

- (CGRect)intialToFrameWithSize:(CGSize)size transitionType:(FMColorTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGFloat presentingMultiplier = (presenting) ? 1 : -1;
    switch (type) {
        case FMColorTransitionTypeUp: {
            frame.origin.y = presentingMultiplier*-2*CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeDown: {
            frame.origin.y = presentingMultiplier*2*CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeLeft: {
            frame.origin.x = presentingMultiplier*2*CGRectGetWidth(frame);
            return frame;
        }
        case FMColorTransitionTypeRight: {
            frame.origin.x = presentingMultiplier*-2*CGRectGetWidth(frame);
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}

- (CGRect)finalColorViewFrameWithSize:(CGSize)size transitionType:(FMColorTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGFloat presentingMultiplier = (presenting) ? 1 : -1;
    switch (type) {
        case FMColorTransitionTypeUp: {
            frame.origin.y = presentingMultiplier * CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeDown: {
            frame.origin.y = presentingMultiplier * -CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeLeft: {
            frame.origin.x = presentingMultiplier * -CGRectGetWidth(frame);
            return frame;
        }
        case FMColorTransitionTypeRight: {
            frame.origin.x = presentingMultiplier * CGRectGetWidth(frame);
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}

- (CGRect)intialColorViewFrameWithSize:(CGSize)size transitionType:(FMColorTransitionType)type presenting:(BOOL)presenting {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGFloat presentingMultiplier = (presenting) ? 1 : -1;
    switch (type) {
        case FMColorTransitionTypeUp: {
            frame.origin.y = presentingMultiplier*-CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeDown: {
            frame.origin.y = presentingMultiplier*CGRectGetHeight(frame);
            return frame;
        }
        case FMColorTransitionTypeLeft: {
            frame.origin.x = presentingMultiplier*CGRectGetWidth(frame);
            return frame;
        }
        case FMColorTransitionTypeRight: {
            frame.origin.x = presentingMultiplier*-CGRectGetWidth(frame);
            return frame;
        }
        default:
            return CGRectZero;
            break;
    }
}

@end
